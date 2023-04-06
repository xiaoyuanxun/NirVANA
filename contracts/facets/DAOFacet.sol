// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import { LibSBT } from "./SBT.sol";

library  LibDAO {

    enum ProposalState {
        pending,
        canceled,
        executed
    }

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.facet.dao.storage");

    struct Proposal {
        string description;
        uint votes;
        ProposalState state;
    }
    
    struct DAOStorage {
        Proposal[] _proposals;
        mapping (uint256 => mapping (address => bool)) voted;
    }

    function diamondStorage() internal pure returns (DAOStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    event ProposalAdded(uint proposalId, string description);
    event Voted(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId, uint votes);
}

contract DAOFacet {

    function addProposal(string memory description) external onlyMember returns (uint) {
        LibDAO.DAOStorage storage ds =  LibDAO.diamondStorage();
        uint proposalId = ds._proposals.length;
        ds._proposals.push(LibDAO.Proposal({
            description: description,
            votes: 0,
            state: LibDAO.ProposalState.pending
        }));
        emit LibDAO.ProposalAdded(proposalId, description);
        return proposalId;
    }

    function vote(uint proposalId) external onlyMember {
        LibDAO.DAOStorage storage ds = LibDAO.diamondStorage();
        require(ds._proposals[proposalId].state == LibDAO.ProposalState.pending, "SimpleDAO: proposal not on pending");
        require(!ds.voted[proposalId][msg.sender], "SimpleDAO: member already voted");

        ds.voted[proposalId][msg.sender] = true;
        ds._proposals[proposalId].votes++;
        emit LibDAO.Voted(proposalId, msg.sender);
    }

    function executeProposal(uint proposalId) external onlyMember {
        LibDAO.DAOStorage storage ds = LibDAO.diamondStorage();
        require(ds._proposals[proposalId].state == LibDAO.ProposalState.pending, "SimpleDAO: proposal not on pending");
        require(ds._proposals[proposalId].votes > (LibSBT.diamondStorage().totalSupply / 2), "SimpleDAO: proposal failed to pass");

        ds._proposals[proposalId].state = LibDAO.ProposalState.executed;
        emit LibDAO.ProposalExecuted(proposalId, ds._proposals[proposalId].votes);
    }

    modifier onlyMember() {
        require(LibSBT.diamondStorage()._balances[msg.sender] > 0 , "SimpleDAO: caller is not a member");
        _;
    }
}
