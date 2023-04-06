/* global ethers */
/* eslint prefer-const: "off" */
//@ts-nocheck

const { getSelectors, 
    FacetCutAction, 
    getRemovedSelectors,
    getRemovedSelectorsBySelector
   } = require('./libraries/diamond.ts')
  
  async function deployFactory () {

    const accounts = await ethers.getSigners()
    const contractOwner = accounts[0]
  
    // Deploy DiamondInit
    // DiamondInit provides a function that is called when the diamond is upgraded or deployed to initialize state variables
    // Read about how the diamondCut function works in the EIP2535 Diamonds standard
    const DiamondFactory = await ethers.getContractFactory('DiamondFactory')
    const diamondFactory = await DiamondFactory.deploy()
    await diamondFactory.deployed()
    console.log('DiamondFactory deployed:', diamondFactory.address)


    const FacetFactory = await ethers.getContractFactory('FacetFactory')
    const facetFactory = await FacetFactory.deploy()
    await facetFactory.deployed()
    console.log('FacetFactory deployed:', facetFactory.address)

  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  if (require.main === module) {
    deployFactory()
      .then(() => process.exit(0))
      .catch(error => {
        console.error(error)
        process.exit(1)
      })
  }
  
  exports.deployFactory = deployFactory
  