// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Diamond.sol";
import { DiamondArgs } from "./Diamond.sol";
import "./facets/DiamondCutFacet.sol";
import "./facets/DiamondLoupeFacet.sol";
import "./facets/OwnershipFacet.sol";
import "./upgradeInitializers/DiamondInit.sol";

contract DiamondFactory {

    // 部署内置的那四个Facet合约, 返回合约地址
    function initDeployFacet() external returns (address[4] memory) {
        address[4] memory facetAddress;
        facetAddress[0] = address(new DiamondInit());
        facetAddress[1] = address(new DiamondCutFacet());
        facetAddress[2] = address(new DiamondLoupeFacet());
        facetAddress[3] = address(new OwnershipFacet());
    
        return facetAddress;
    }

    // 传入合约地址 和 函数选择器
    // 先传 内置的 Facet， 再传SBT
    // 注意函数选择器的去重
    // const diamondArgs = {
    //   owner: contractOwner.address,
    //   init: diamondInit.address,
    //   initCalldata: functionCall
    // }
    function deployDiamond(IDiamondCut.FacetCut[] memory _diamondCut, DiamondArgs memory _args) external returns (address) {
        // Contract x = new Contract{value: _value}(params)
        return address(new Diamond(_diamondCut, _args));
    }

}    