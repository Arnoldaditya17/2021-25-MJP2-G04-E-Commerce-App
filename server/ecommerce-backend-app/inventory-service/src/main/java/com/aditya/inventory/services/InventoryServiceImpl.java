package com.aditya.inventory.services;

import com.aditya.inventory.dto.CreateInventoryDto;
import com.aditya.inventory.dto.InventoryDto;
import com.aditya.inventory.models.InventoryEntity;
import com.aditya.inventory.repositories.InventoryRepository;
import com.aditya.product.dtos.ProductDto;
import com.aditya.product.models.ProductEntity;
import com.aditya.product.repositories.ProductRepository;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InventoryServiceImpl implements InventoryService {

	private final InventoryRepository inventoryRepository;

	private final ProductRepository productRepository;

	private final ModelMapper modelMapper;

	public InventoryServiceImpl(InventoryRepository inventoryRepository, ProductRepository productRepository, ModelMapper modelMapper) {
		this.inventoryRepository = inventoryRepository;
		this.productRepository = productRepository;
		this.modelMapper = modelMapper;
	}

	@Override
	public InventoryDto createInventory(CreateInventoryDto createInventoryDto) {
		ProductEntity product = productRepository.findBySkuCode(createInventoryDto.getSkuCode())
				.orElseThrow(() -> new RuntimeException("Product with SKU " + createInventoryDto.getSkuCode() + " not found"));
		InventoryEntity inventoryEntity = new InventoryEntity();
		inventoryEntity.setQuantity(createInventoryDto.getQuantity());
		inventoryEntity.setMarketPrice(createInventoryDto.getMarketPrice());
		inventoryEntity.setSalePrice(createInventoryDto.getSalePrice());
		inventoryEntity.setSkuCode(createInventoryDto.getSkuCode());
		inventoryEntity.setProduct(product);
		InventoryEntity savedInventory = inventoryRepository.save(inventoryEntity);
		return modelMapper.map(savedInventory, InventoryDto.class);
	}

	@Override
	public InventoryDto updateInventory(InventoryDto inventoryDto) {
		InventoryEntity existingInventory = inventoryRepository.findBySkuCode(inventoryDto.getSkuCode())
				.orElseThrow(() -> new RuntimeException("No inventory found for SKU " + inventoryDto.getSkuCode()));
		existingInventory.setQuantity(inventoryDto.getQuantity());
		InventoryEntity updatedInventory = inventoryRepository.save(existingInventory);
		return modelMapper.map(updatedInventory, InventoryDto.class);
	}

	@Override
	public InventoryDto getInventory(String skuCode) {
		InventoryEntity inventoryEntity = inventoryRepository.findBySkuCode(skuCode)
				.orElseThrow(() -> new RuntimeException("No inventory found for SKU " + skuCode));

		InventoryDto inventoryDto = modelMapper.map(inventoryEntity, InventoryDto.class);

		inventoryDto.setSkuCode(inventoryEntity.getProduct().getSkuCode());

		return inventoryDto;
	}

	@Override
	public Page<InventoryDto> getAllInventory(Pageable pageable) {
		Page<InventoryEntity> inventoryEntityPage = inventoryRepository.findAll(pageable);

		List<InventoryDto> dtoList = inventoryEntityPage.getContent().stream().map(inventoryEntity -> {
			InventoryDto inventoryDto = modelMapper.map(inventoryEntity, InventoryDto.class);
			inventoryDto.setSkuCode(inventoryEntity.getProduct().getSkuCode());
			ProductDto productDto = modelMapper.map(inventoryEntity.getProduct(), ProductDto.class);
			modelMapper.map(inventoryEntity.getProduct(), ProductEntity.class);
			inventoryDto.setProduct(productDto);
			return inventoryDto;
		}).toList();

		return new PageImpl<>(dtoList, pageable, inventoryEntityPage.getTotalElements());
	}

	@Override
	public void deleteInventory(String skuCode) {
		InventoryEntity inventoryEntity = inventoryRepository.findBySkuCode(skuCode)
				.orElseThrow(() -> new RuntimeException("No inventory found for SKU " + skuCode));
		inventoryRepository.delete(inventoryEntity);
	}

	@Override
	public Optional<InventoryEntity> findBySkuCode(String skuCode) {
		return inventoryRepository.findBySkuCode(skuCode);
	}
}
