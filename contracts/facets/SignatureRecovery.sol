// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../libraries/ECDSA.sol";
import "../interfaces/ISignatureRecovery.sol";
import "../interfaces/IERC165.sol";
import "./SBT.sol";
import "../libraries/Context.sol";
import "../libraries/EIP712.sol";

error MethodNotAllowed(address _recipient);


contract SignatureRecovery is Context, IERC165, ISignatureRecovery, EIP712 {
    using ECDSA for bytes32;

    bytes32 private constant _RECOVERY_TYPEHASH =
        keccak256("Recovery(address from,address recipient)");

    constructor(string memory name, string memory version) EIP712(name, version) {

    }

    function recover(
        address from,
        bytes memory signature
    ) public virtual {
        if (from == address(0)) revert("from address is zero");
        address recipient = _msgSender();
        if (from == recipient) revert MethodNotAllowed(recipient);
        bytes32 digest = _hashTypedDataV4(
            keccak256(abi.encode(_RECOVERY_TYPEHASH, from, recipient))
        );
        if (digest.recover(signature) != from) revert Forbidden();
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