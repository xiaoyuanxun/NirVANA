# NirVANA: A tool for creating modular SBTs based on ERC2535

NirVANA is a modular SBT distribution tool based on ERC2535 that supports adding/replacing/removing modules after contract deployment. Currently, it supports DAO governance, social recovery, and ZK verification modules.

## How does NirVANA work?

NirVANA is based on the ERC2535 Diamond contract, which contains a main Diamond contract as well as other cut Facet contracts. We offer multiple SBT standards, as well as multiple modular Facet contracts.

NirVANA provides a user-friendly interface to create and manage SBTs, as well as the freedom to add/replace/delete modules.

## Features

- Single SBT contract address but supports unlimited modular contract functionality: only one contract address need to interact with

- Add/replace/remove modules are still supported after the SBT contract is deployed

- Logical module contracts are reusable, just need only one deployment

![](https://kh4t2-waaaa-aaaal-qbhbq-cai.raw.ic0.app/file/uF8HoUr-i8ZeEa--iN7aI)

## NirVANA's SBT standard

- Based on ERC5192 and compatible with ERC2535 interface standard, storage changed to Diamond Storage

## NirVANA's modules

- DAOFacet: DAO governance module, users with SBT can perform DAO governance, initiate proposals, conduct voting, and execute proposals

- RecoveryFacet: Recovery module that supports signature recovery as well as social recovery

- ZKFacet: A ZK validation module that allows other contracts to validate an attribute of a user's SBT without exposing the value of the attribute. For example, if an SBT represents an age, other contracts can verify that the age attribute of a particular SBT is greater than a threshold value through the ZK verification module without exposing the specific value.

## Contract On Scroll

- DiamondInit : [0xa2a438492eC98e58087e1D5cef284EDCBd022B0f](https://blockscout.scroll.io/address/0xa2a438492eC98e58087e1D5cef284EDCBd022B0f)

- DiamondCutFacet : [0xeFbF963506C986397FC92A63E0b173f25248BC99](https://blockscout.scroll.io/address/0xeFbF963506C986397FC92A63E0b173f25248BC99)

- DiamondLoupeFacet : [0xdf9479F11f28A6e887175df04E36E6848f27E32b](https://blockscout.scroll.io/address/0xdf9479F11f28A6e887175df04E36E6848f27E32b)

- OwnershipFacet : [0x98275A685ea0513b4d6b83D1c53fE14F0f41ba57](https://blockscout.scroll.io/address/0x98275A685ea0513b4d6b83D1c53fE14F0f41ba57)

- SBTFacet : [0x5895ce8E7C6530066903f727b8C454f502B5865B](https://blockscout.scroll.io/address/0x5895ce8E7C6530066903f727b8C454f502B5865B)

- DAOFacet : [0x6C6ECfdefd7401226a9B3D19AA3ABC2631d8B9a7](https://blockscout.scroll.io/address/0x6C6ECfdefd7401226a9B3D19AA3ABC2631d8B9a7)

- RecoveryFacet : [0x8558d078a1D3A1dbe9A0e96503Ea21c3DE573D55](https://blockscout.scroll.io/address/0x8558d078a1D3A1dbe9A0e96503Ea21c3DE573D55)

- DiamondFactory : [0x56052921464EF0f95e2f20958E7a8B8aA3fDa6F4](https://blockscout.scroll.io/address/0x56052921464EF0f95e2f20958E7a8B8aA3fDa6F4)

- FacetFactory : [0xBbD62f7b7529DabBaC58CD62b6d98393F8B86F42](https://blockscout.scroll.io/address/0xBbD62f7b7529DabBaC58CD62b6d98393F8B86F42)

- SoulMinter : [0x68E519f202C38f02E12C821d90b8114aa40B4b66](https://blockscout.scroll.io/address/0x68E519f202C38f02E12C821d90b8114aa40B4b66)

- ZK_Verifier : [0xeDB28103a9A0116A13B03Cf87B2D66129cC6fE01](https://blockscout.scroll.io/address/0xeDB28103a9A0116A13B03Cf87B2D66129cC6fE01)

- PrivateOver18Airdrop : [0xC5A1a8b1fdD40c57EbF7292Fea6D77bd4d1Cd428](https://blockscout.scroll.io/address/0xC5A1a8b1fdD40c57EbF7292Fea6D77bd4d1Cd428)

