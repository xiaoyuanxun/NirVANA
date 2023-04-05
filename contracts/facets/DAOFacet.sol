pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

library  LibDAO {

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.facet.dao.storage");
    bytes32 constant SBT_STORAGE_POSITION = keccak256("diamond.facet.sbt.storage");

    struct Proposal {
        string description;
        uint votes;
        mapping(address => bool) voted;
        bool executed;
    }

    struct DAOStorage {
        // IERC721 _nftContract;
        Proposal[] _proposals;
        mapping(address => bool) _members;
    }    

    struct ERC721Storage {
        string _name;
        string _symbol;
        mapping(uint256 => address)  _owners;
        mapping(address => uint256)  _balances;
        mapping(uint256 => address)  _tokenApprovals;
        mapping(address => mapping(address => bool))  _operatorApprovals;
    }    

    function erc721Storage() internal pure returns (ERC721Storage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    event ProposalAdded(uint proposalId, string description);
    event Voted(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId, uint votes);


    function diamondStorage() internal pure returns (DAOStorage storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

}

contract SimpleDAO is ERC721Holder {

    // function setConstructor(address nftContract) external {
    //     _nftContract = IERC721(nftContract);
    // }

    // function addMember(address member) external {
    //     require(_nftContract.balanceOf(member) > 0, "SimpleDAO: only NFT holders can become members");
    //     _members[member] = true;
    // }

    // function addProposal(string memory description) external onlyMember returns (uint) {
    //     uint proposalId = _proposals.length;
    //     _proposals.push(Proposal({
    //         description: description,
    //         votes: 0,
    //         executed: false
    //     }));
    //     emit ProposalAdded(proposalId, description);
    //     return proposalId;
    // }

    // function vote(uint proposalId) external onlyMember {
    //     require(!_proposals[proposalId].executed, "SimpleDAO: proposal already executed");
    //     require(!_proposals[proposalId].voted[msg.sender], "SimpleDAO: member already voted");

    //     _proposals[proposalId].voted[msg.sender] = true;
    //     _proposals[proposalId].votes++;
    //     emit Voted(proposalId, msg.sender);
    // }

    // function executeProposal(uint proposalId) external onlyMember {
    //     require(!_proposals[proposalId].executed, "SimpleDAO: proposal already executed");
    //     require(_proposals[proposalId].votes > (_nftContract.totalSupply() / 2), "SimpleDAO: proposal failed to pass");

    //     _proposals[proposalId].executed = true;
    //     emit ProposalExecuted(proposalId, _proposals[proposalId].votes);
    // }

    // modifier onlyMember() {
    //     require(_members[msg.sender], "SimpleDAO: caller is not a member");
    //     _;
    // }
}
