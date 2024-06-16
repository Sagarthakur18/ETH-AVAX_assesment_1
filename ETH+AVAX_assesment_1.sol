// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract IndianCabinetMinisters {
    struct Minister {
        string name;
        string department;
        bool isActive;
    }

    mapping(uint => Minister) private ministers; // Mapping of minister IDs to Minister structs
    uint private ministerCount; // Counter for minister IDs
    address private owner; // Owner of the contract (admin)

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Function to add a new minister
    function addMinister(string memory _name, string memory _department) public onlyOwner {
        require(bytes(_name).length > 0, "Minister name must not be empty");
        require(bytes(_department).length > 0, "Minister department must not be empty");
        ministerCount++;
        ministers[ministerCount] = Minister(_name, _department, true);
    }

    // Function to get minister details
    function getMinister(uint _id) public view returns (string memory, string memory, bool) {
        require(_id > 0 && _id <= ministerCount, "Minister ID does not exist");
        Minister memory minister = ministers[_id];
        return (minister.name, minister.department, minister.isActive);
    }

    // Function to update minister portfolio
    function updateDepartment(uint _id, string memory _newDepartment) public onlyOwner {
        require(_id > 0 && _id <= ministerCount, "Minister ID does not exist");
        require(bytes(_newDepartment).length > 0, "New portfolio must not be empty");
        ministers[_id].department = _newDepartment;
    }

    // Function to deactivate a minister
    function deactivateMinister(uint _id) public onlyOwner {
        require(_id > 0 && _id <= ministerCount, "Minister ID does not exist");
        ministers[_id].isActive = false;
    }

    // Function using assert to check a condition
    function testAssert(uint _id) public view {
        Minister memory minister = ministers[_id];
        // Using assert to ensure the minister's name is always not empty
        assert(bytes(minister.name).length > 0);
    }

    // Function using require to check a condition
    function testRequire(uint _id) public view {
        // Using require to ensure the minister ID exists
        require(_id > 0 && _id <= ministerCount, "Minister ID does not exist");
    }

    // Function using revert to check a condition
    function testRevert(uint _id) public view {
        // Using revert to check if the minister ID does not exist
        if (_id == 0 || _id > ministerCount) {
            revert("Minister ID does not exist");
        }
    }
}
