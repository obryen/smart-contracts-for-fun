// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

import "./simple-storage-with-struct.sol";

contract ExtraStorage is SimpleStorage {
  // add 5

  function store(uint256 _number)public override{
     faveNumber = _number + 5;
  }
}
