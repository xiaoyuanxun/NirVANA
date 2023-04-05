/* global ethers */
/* eslint prefer-const: "off" */
//@ts-nocheck

const { getSelectors, 
    FacetCutAction, 
    getRemovedSelectors,
    getRemovedSelectorsBySelector
   } = require('./libraries/diamond.ts')

const { deployDiamond } = require('./deploy.ts')

async function testSBT () {
    // 拿到合约实例
    let diamondAddress = await deployDiamond()
    let diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress)
    let diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress)
    let ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress)
    let sbtFacet = await ethers.getContractAt('SBT', diamondAddress)

    // 测试函数
    let setConstructorResult = await sbtFacet.setConstructor("NirVANA_SBT_name_", "NirVANA_SBT_symbol_")
     
    let nameResult = await sbtFacet.name()
    console.log('name: ' + nameResult)

    let symbolResult = await sbtFacet.symbol()
    console.log('symbol: ' + symbolResult)

}

if (require.main === module) {
    testSBT()
      .then(() => process.exit(0))
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }
  
  exports.testSBT = testSBT
