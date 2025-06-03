// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
  SimpleStorage[] public listOfSimpleStorageContracts;

  function createSimpleStorageContract() public {
    SimpleStorage simpleStorageContract = new SimpleStorage();
    listOfSimpleStorageContracts.push(simpleStorageContract);
  }

  function sfStore(uint256 simpleStorageIndex, uint256 simpleStorageNumber) public {
    // Address
    // ABI - Application Binary Interface
    SimpleStorage simpleStorage = listOfSimpleStorageContracts[simpleStorageIndex];
    simpleStorage.store(simpleStorageNumber);
  }

  function sfGet(uint256 simpleStorageIndex) public view returns (uint256) {
    return listOfSimpleStorageContracts[simpleStorageIndex].retrieve();
  }
}
