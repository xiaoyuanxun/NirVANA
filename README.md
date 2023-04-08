# NirVANA: A tool for creating modular SBTs based on ERC2535

NirVANA is a modular SBT distribution tool based on ERC2535 that supports adding/replacing/removing modules after contract deployment. Currently, it supports DAO governance, social recovery, and ZK verification modules.

NirVANA是一个基于ERC2535的模块化SBT发行工具，且支持合约部署后再次添加/替换/删除 模块，目前已支持：DAO治理，社交恢复，ZK验证模块。

## How does NirVANA work?

NirVANA provides a user-friendly interface for developers to create and manage their SBTs. It simplifies the process of creating modular SBTs by providing a comprehensive set of tools

NirVANA 基于ERC2535钻石合约，钻石合约支持多个切面逻辑合约共享钻石合约的内存，从而
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

## 项目提交信息

1. 项目名称: NirVANA
2. 项目图片: ![](https://kh4t2-waaaa-aaaal-qbhbq-cai.raw.ic0.app/file/leEZpRRFMO0zzSBwJjzeq)
3. 简介: NirVANA是一个基于ERC2535的模块化SBT发行工具，且支持合约部署后再次添加/替换/删除 模块，目前已支持：DAO治理，社交恢复，ZK验证模块。
4. 队长和队员: 队长Harlan009, 队员Xun勋
5. 黑客松目标: 完成项目DEMO
6. 黑客松前2日进度：

    第一天进度：完成SBT合约及核心模块合约部署， 前端完成创建SBT页面

    第二天进度：前端完成landing page，profile等页面开发，完成模块拖拽选择模块，完成SBT模块化创建逻辑。改进合约初始化机制，逻辑模块合约一次性部署；初步集成ZK验证模块

7. Demo视频链接: 
8. 项目 github repo 链接：https://github.com/xiaoyuanxun/NirVANA
9. 是否基于以前项目: 基于[ERC2535](https://eips.ethereum.org/EIPS/eip-2535)标准
10. 项目Demo链接: https://nirvava.vercel.app/
