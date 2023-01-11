// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./simple-storage-with-struct.sol";

contract StorageFactory {
    SimpleStorage[] public ssList;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStore = new SimpleStorage();
        ssList.push(simpleStore);
    }

    function sfStore(uint256 _ssIndex, uint256 _ssNumber) public {
        ssList[_ssIndex].store(_ssNumber);
    }

    function sfGet(uint256 _index) public view returns (uint256) {
        return ssList[_index].retrive();
    }
}
