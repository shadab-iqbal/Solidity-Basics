// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// basically copy and pasting the whole code of SimpleStorage.sol
// it comes packed with the abi of the contract, so that we can interact with the contract using the abi
import "./SimpleStorage.sol";

contract StorageFactory {
    // storing the SimpleStorage contracts in this array 
    SimpleStorage[] public simpleStorage;

    // deploying the SimpleStorage contract and saving the (contract + abi) in the array
    function createSimpleStorageContract() public {
        simpleStorage.push(new SimpleStorage());
    }

    // using the SimpleStorage contract to call the "store" function
    function sfStore(uint256 idx, uint256 num) public {
        simpleStorage[idx].store(num);
    }

    // using the SimpleStorage contract to call the "retrieve" function
    function sfRetrieve(uint256 idx) public view returns(uint256) {
        return simpleStorage[idx].retrieve();
    }
   
}