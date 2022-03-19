// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// Ownable이 있어야 추후 커스터마이징이 가능하다.
contract MintGem is ERC721Enumerable, Ownable {
  // JSON URI 받아올 변수
  string uri;

  // 배포 시 한 번 실행
  constructor(string memory _name, string memory _symbol, string memory _uri) ERC721(_name, _symbol) {
    // 배포 단계에서 JSON URI 받아올 예정
    uri = _uri;
  }

  // gemData에 대한 structure
  struct GemData {
    uint gemRank;
    uint gemType;
  }
  // tokenId를 input으로 받아서 GemData 출력
  // tokenId가 1번이면 gemRank는 몇이고 gemType는 몇이다... 를 알 수 있다.
  mapping(uint => GemData) public gemData;

  // 1 klay
  uint gemPrice = 1000000000000000000;

  // MetaData (`uri/1/1.json` 형식의 결과값이 나와야 한다.)
  function tokenURI(uint _tokenId) override public view returns(string memory) {
    // uint를 string으로 바꾸기 위해 사용
    string memory gemRank = Strings.toString(gemData[_tokenId].gemRank);
    string memory gemType = Strings.toString(gemData[_tokenId].gemType);
    return string(abi.encodePacked(uri, '/', gemRank, '/', gemType, '.json'));
  }

  // mint
  function mintGem() public payable {
    // msg.value: msg.sender가 보내는 klayton의 양
    require(gemPrice <= msg.value, "Not enough Klay.");

    // totalSupply: 발행한 총 NFT 양 -> 이것을 바탕으로 1씩 더해 tokenId를 생성할 수 있다.
    uint tokenId = totalSupply() + 1;

    // owner(): 이 contract를 소유한 계정
    payable(owner()).transfer(msg.value);

    gemData[tokenId] = GemData(3, 3);

    /* 
      mint ... 인자 2개 필요: 
      1. 누가 민팅하는지(msg.sender)
      2. tokenId
    */
    _mint(msg.sender, tokenId);
  }
}