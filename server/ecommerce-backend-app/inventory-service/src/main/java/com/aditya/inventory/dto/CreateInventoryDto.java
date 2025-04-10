package com.aditya.inventory.dto;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.UUID;

@Data
public class CreateInventoryDto implements Serializable {

	@Serial
	private static final long serialVersionUID = 8087916565749526750L;

	private UUID id;

	private String skuCode;

	private Integer quantity;

	private Double marketPrice;

	private Double salePrice;

}
