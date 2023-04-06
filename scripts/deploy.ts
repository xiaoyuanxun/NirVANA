/* global ethers */
/* eslint prefer-const: "off" */
//@ts-nocheck

const { getSelectors, 
  FacetCutAction, 
  getRemovedSelectors,
  getRemovedSelectorsBySelector
 } = require('./libraries/diamond.ts')

async function deployDiamond () {
  const accounts = await ethers.getSigners()
  const contractOwner = accounts[0]

  // Deploy DiamondInit
  // DiamondInit provides a function that is called when the diamond is upgraded or deployed to initialize state variables
  // Read about how the diamondCut function works in the EIP2535 Diamonds standard
  const DiamondInit = await ethers.getContractFactory('DiamondInit')
  const diamondInit = await DiamondInit.deploy()
  await diamondInit.deployed()
  console.log('DiamondInit deployed:', diamondInit.address)

  // Deploy facets and set the `facetCuts` variable
  console.log('')
  console.log('Deploying facets')
  const FacetNames = [
    'DiamondCutFacet',
    'DiamondLoupeFacet',
    'OwnershipFacet'
  ]
  // The `facetCuts` variable is the FacetCut[] that contains the functions to add during diamond deployment
  const facetCuts = []
  for (const FacetName of FacetNames) {
    const Facet = await ethers.getContractFactory(FacetName)
    const facet = await Facet.deploy()
    await facet.deployed()
    console.log(`${FacetName} deployed: ${facet.address}`)
    facetCuts.push({
      facetAddress: facet.address,
      action: FacetCutAction.Add,
      functionSelectors: getSelectors(facet)
    })
  }

  // // 部署ERC721 
  // const ERC721Facet = await ethers.getContractFactory('ERC721')
  // const erc721Facet = await ERC721Facet.deploy()
  // await erc721Facet.deployed()
  // console.log(`ERC721Facet deployed: ${erc721Facet.address}`)
  // console.log(getSelectors(erc721Facet))
  // let erc721Selectors = getRemovedSelectorsBySelector(getSelectors(erc721Facet), facetCuts[0].functionSelectors)
  // console.log(erc721Selectors + '\n')
  // erc721Selectors = getRemovedSelectorsBySelector(erc721Selectors, facetCuts[1].functionSelectors)
  // console.log(erc721Selectors + '\n')
  // erc721Selectors = getRemovedSelectorsBySelector(erc721Selectors, facetCuts[2].functionSelectors)
  // console.log(erc721Selectors + '\n')
  // facetCuts.push({
  //   facetAddress: erc721Facet.address,
  //   action: FacetCutAction.Add,
  //   functionSelectors: erc721Selectors
  // })

  // 部署SBT
  const SBTFacet = await ethers.getContractFactory('SBT')
  const sbtFacet = await SBTFacet.deploy()
  await sbtFacet.deployed()
  console.log(`SBTFacet deployed: ${sbtFacet.address}`)
  // console.log(getSelectors(sbtFacet))
  let sbtFacetSelectors = getRemovedSelectorsBySelector(getSelectors(sbtFacet), facetCuts[0].functionSelectors)
  // console.log(sbtFacetSelectors + '\n')
  sbtFacetSelectors = getRemovedSelectorsBySelector(sbtFacetSelectors, facetCuts[1].functionSelectors)
  // console.log(sbtFacetSelectors + '\n')
  sbtFacetSelectors = getRemovedSelectorsBySelector(sbtFacetSelectors, facetCuts[2].functionSelectors)
  // console.log(sbtFacetSelectors + '\n')
  facetCuts.push({
    facetAddress: sbtFacet.address,
    action: FacetCutAction.Add,
    functionSelectors: sbtFacetSelectors
  })

  // Creating a function call
  // This call gets executed during deployment and can also be executed in upgrades
  // It is executed with delegatecall on the DiamondInit address.
  let functionCall = diamondInit.interface.encodeFunctionData('init')

  // Setting arguments that will be used in the diamond constructor
  const diamondArgs = {
    owner: contractOwner.address,
    init: diamondInit.address,
    initCalldata: functionCall
  }

  // deploy Diamond
  const Diamond = await ethers.getContractFactory('Diamond')
  const diamond = await Diamond.deploy(facetCuts, diamondArgs)
  await diamond.deployed()
  console.log()
  console.log('Diamond deployed:', diamond.address)

  // returning the address of the diamond
  return diamond.address
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
if (require.main === module) {
  deployDiamond()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error)
      process.exit(1)
    })
}

exports.deployDiamond = deployDiamond
