// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

// "is" keyword is for inheriting the SimpleStorage contract

contract ExtraStorage is SimpleStorage {

    // "override" keyword is necessary for overriding a function from the parent contract
    function store(uint256 _num) public override{
        num = _num + 5;
    }

}