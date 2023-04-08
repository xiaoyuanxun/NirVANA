// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../libraries/ECDSA.sol";
import "../interfaces/ISignatureRecovery.sol";
import "../interfaces/IERC165.sol";
import "./SBT.sol";
import "../libraries/Context.sol";
import "../libraries/EIP712.sol";

error MethodNotAllowed(address _recipient);

library LibSignatureRecovery {

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.facet.signaturerecovery.storage");

    struct DiamondStorage {
        bytes32  _CACHED_DOMAIN_SEPARATOR;
        uint256  _CACHED_CHAIN_ID;
        address  _CACHED_THIS;

        bytes32  _HASHED_NAME;
        bytes32  _HASHED_VERSION;
        bytes32  _TYPE_HASH;   

        bytes32 _RECOVERY_TYPEHASH;
    }    


    function diamondStorage() internal pure returns (DiamondStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    function setConstructor(string memory name, string memory version) internal {
        bytes32 hashedName = keccak256(bytes(name));
        bytes32 hashedVersion = keccak256(bytes(version));
        bytes32 typeHash = keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
        DiamondStorage storage ds = diamondStorage();
        ds._HASHED_NAME = hashedName;
        ds._HASHED_VERSION = hashedVersion;
        ds._CACHED_CHAIN_ID = block.chainid;
        ds._CACHED_DOMAIN_SEPARATOR = _buildDomainSeparator(typeHash, hashedName, hashedVersion);
        ds._CACHED_THIS = address(this);
        ds._TYPE_HASH = typeHash;

        ds._RECOVERY_TYPEHASH = keccak256("Recovery(address from,address recipient)");
    }

    function _buildDomainSeparator(
        bytes32 typeHash,
        bytes32 nameHash,
        bytes32 versionHash
    ) internal view returns (bytes32) {
        return keccak256(abi.encode(typeHash, nameHash, versionHash, block.chainid, address(this)));
    }

    function _domainSeparatorV4() internal view returns (bytes32) {
        DiamondStorage storage ds = diamondStorage();
        if (address(this) == ds._CACHED_THIS && block.chainid == ds._CACHED_CHAIN_ID) {
            return ds._CACHED_DOMAIN_SEPARATOR;
        } else {
            return _buildDomainSeparator(ds._TYPE_HASH, ds._HASHED_NAME, ds._HASHED_VERSION);
        }
    }

}

contract SignatureRecovery is Context, IERC165, ISignatureRecovery {
    using ECDSA for bytes32;

    function recover(
        address from,
        uint256 tokenId,
        bytes memory signature
    ) public virtual {
        if (from == address(0)) revert("from address is zero");
        address recipient = _msgSender();
        if (from == recipient) revert MethodNotAllowed(recipient);
        bytes32 digest = _hashTypedDataV4(
            keccak256(abi.encode(
                LibSignatureRecovery.diamondStorage()._RECOVERY_TYPEHASH,
                from, 
                recipient
            ))
        );
        if (digest.recover(signature) != from) revert Forbidden();
        LibSBT.diamondStorage()._owners[tokenId] = _msgSender();
    }


    function _hashTypedDataV4(bytes32 structHash) internal view virtual returns (bytes32) {
        return ECDSA.toTypedDataHash(_domainSeparatorV4(), structHash);
    }

    function _domainSeparatorV4() internal view returns (bytes32) {
        return LibSignatureRecovery._domainSeparatorV4();
    }

    function _buildDomainSeparator(
        bytes32 typeHash,
        bytes32 nameHash,
        bytes32 versionHash
    ) private view returns (bytes32) {
        return LibSignatureRecovery._buildDomainSeparator(
            typeHash,
            nameHash,
            versionHash
        );
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(IERC165) returns (bool) {
        return
            interfaceId == type(ISignatureRecovery).interfaceId;
            // ||
            // // super.supportsInterface(interfaceId);
    }

}