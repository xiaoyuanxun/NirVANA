pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "../interfaces/ISignatureRecovery.sol";
import "./SBT.sol";

contract SignatureRecovery is ISignatureRecovery {
    using ECDSA for bytes32;

    bytes32 private constant _RECOVERY_TYPEHASH =
        keccak256("Recovery(address from,address recipient)");

    function recover(
        address from,
        bytes memory signature
    ) public virtual override {
        if (from == address(0)) revert 'from address is zero';
        address recipient = _msgSender();
        if (from == recipient) revert MethodNotAllowed(recipient);
        bytes32 digest = _hashTypedDataV4(
            keccak256(abi.encode(_RECOVERY_TYPEHASH, from, recipient))
        );
        if (digest.recover(signature) != from) revert Forbidden();
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(IERC165, ERC5727Enumerable) returns (bool) {
        return
            interfaceId == type(ISignatureRecovery).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}