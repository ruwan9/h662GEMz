// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MintGem is ERC721Enumerable {
  // 배포 시 한 번 실행
  constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

  // mint
  function mintGem() public {

    // totalSupply: 발행한 총 NFT 양 -> 이것을 바탕으로 1씩 더해 tokenId를 생성할 수 있다.
    uint tokenId = totalSupply() + 1;

    /* 
      인자 2개 필요: 
      1. 누가 민팅하는지(msg.sender)
      2. tokenId
    */
    _mint(msg.sender, tokenId);
  }
}