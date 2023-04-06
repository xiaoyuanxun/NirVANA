// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./facets/SBT.sol";
import "./facets/SignatureRecovery.sol";
import "./facets/DAOFacet.sol";

contract FacetFactory {

    function deploySBTFacet() external returns (address) {
        return address(new SBT());
    }

    function deployDAOFacet() external returns (address) {
        return address(new DAOFacet());
    }

    function deploySignatureRecovery() external returns (address) {
        return address(new SignatureRecovery());        
    }
}    