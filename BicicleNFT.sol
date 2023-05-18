// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BicycleNFT is ERC721 {
    struct Bicycle {
        string name;
        uint256 cuadroId;
        uint256 manubrioId;
        uint256 ruedasId;
        uint256 equipoId;
        // Agrega más propiedades de la bicicleta según tus necesidades
    }

    struct Cuadro {
        string name;
        // Agrega más propiedades del cuadro según tus necesidades
    }

    struct Manubrio {
        string name;
        // Agrega más propiedades del manubrio según tus necesidades
    }

    struct Ruedas {
        string name;
        // Agrega más propiedades de las ruedas según tus necesidades
    }

    struct Equipo {
        string name;
        // Agrega más propiedades del equipo según tus necesidades
    }

    mapping(uint256 => Bicycle) public bicycles;
    mapping(uint256 => Cuadro) public cuadros;
    mapping(uint256 => Manubrio) public manubrios;
    mapping(uint256 => Ruedas) public ruedas;
    mapping(uint256 => Equipo) public equipos;

    uint256 private currentTokenId = 1;
    uint256 private currentCuadroId = 1;
    uint256 private currentManubrioId = 1;
    uint256 private currentRuedasId = 1;
    uint256 private currentEquipoId = 1;

    constructor() ERC721("BicycleNFT", "BICYCLE10") {}

    function mintBicycle(address to, string memory name, uint256 cuadroId, uint256 manubrioId, uint256 ruedasId, uint256 equipoId) external {
        uint256 tokenId = currentTokenId;
        currentTokenId++;

        bicycles[tokenId] = Bicycle(name, cuadroId, manubrioId, ruedasId, equipoId);
        _safeMint(to, tokenId);
    }

    function mintCuadro(string memory name) external {
        uint256 cuadroId = currentCuadroId;
        currentCuadroId++;

        cuadros[cuadroId] = Cuadro(name);
    }

    function mintManubrio(string memory name) external {
        uint256 manubrioId = currentManubrioId;
        currentManubrioId++;

        manubrios[manubrioId] = Manubrio(name);
    }

    function mintRuedas(string memory name) external {
        uint256 ruedasId = currentRuedasId;
        currentRuedasId++;

        ruedas[ruedasId] = Ruedas(name);
    }

    function mintEquipo(string memory name) external {
        uint256 equipoId = currentEquipoId;
        currentEquipoId++;

        equipos[equipoId] = Equipo(name);
    }

    function getAllBicycles() external view returns (Bicycle[] memory) {
        uint256 totalBicycles = currentTokenId - 1;
        Bicycle[] memory allBicycles = new Bicycle[](totalBicycles);

        for (uint256 i = 1; i <= totalBicycles; i++) {
            allBicycles[i - 1] = bicycles[i];
        }
        return allBicycles;
    }
    
    function getBicycleDetails(uint256 bicycleId) external view returns (string memory, uint256, uint256, uint256, uint256) {
        require(bicycleId > 0 && bicycleId <= currentTokenId, "Invalid bicycle ID");
        Bicycle storage bicycle = bicycles[bicycleId];
        return (bicycle.name, bicycle.cuadroId, bicycle.ruedasId, bicycle.manubrioId, bicycle.equipoId);
    }
}
