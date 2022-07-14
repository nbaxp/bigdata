CREATE DATABASE inventory;

USE inventory;

CREATE TABLE products (
    id LARGEINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512),
    weight FLOAT
) UNIQUE KEY(`id`) DISTRIBUTED BY HASH(`id`) BUCKETS 1 PROPERTIES ("replication_num" = "1");

CREATE ROUTINE LOAD inventory.loadproducts on products
PROPERTIES (
    "desired_concurrent_number" = "3",
    "max_batch_interval" = "20",
    "max_batch_rows" = "300000",
    "max_batch_size" = "209715200",
    "strict_mode" = "false",
    "format" = "json",
    "json_root" = "$.after"
)
FROM
KAFKA (
    "kafka_broker_list" = "kafka:9092",
    "kafka_topic" = "mysql-ns.inventory.products"
);