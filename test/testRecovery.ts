/* global describe it before ethers */
//@ts-nocheck

const {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets,
    getRemovedSelectorsBySelector
  } = require('../scripts/libraries/diamond.ts')
  
  const { deployDiamond } = require('../scripts/deployRecovery.ts')
  
  const { assert } = require('chai')
  
  describe('Signature Recovery Facet Test', async function () {
    let diamondAddress
    let diamondCutFacet
    let diamondLoupeFacet
    let ownershipFacet
    let sbtFacet
    let recoveryFacet
    let tx
    let receipt
    let result
    const addresses = []
  
    before(async function () {
      diamondAddress = await deployDiamond()
      diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress)
      diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress)
      ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress)
      sbtFacet = await ethers.getContractAt('SBT', diamondAddress)
      recoveryFacet = await ethers.getContractAt('SignatureRecovery', diamondAddress)
    })
  
    it('should have 5 facets -- call to facetAddresse function', async () => {
      for (const address of await diamondLoupeFacet.facetAddresses()) {
        addresses.push(address)
      }
  
      assert.equal(addresses.length, 5)
    })
    
  })
  