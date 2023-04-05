/* global ethers */
/* eslint prefer-const: "off" */
//@ts-nocheck

const { getSelectors, 
    FacetCutAction, 
    getRemovedSelectors,
    getRemovedSelectorsBySelector
   } = require('./libraries/diamond.ts')

const { deployDiamond } = require('./deploy.ts')

async function testERC721 () {
    // 拿到合约实例
    let diamondAddress = await deployDiamond()
    let diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress)
    let diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress)
    let ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress)
    let erc721Facet = await ethers.getContractAt('ERC721', diamondAddress)

    // 测试函数
    let setConstructorResult = await erc721Facet.setConstructor("NirVANA_name_", "NirVANA_symbol_")
     
    let nameResult = await erc721Facet.name()
    console.log('name: ' + nameResult)

    let symbolResult = await erc721Facet.symbol()
    console.log('symbol: ' + symbolResult)

}

if (require.main === module) {
    testERC721()
      .then(() => process.exit(0))
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }
  
  exports.testERC721 = testERC721
