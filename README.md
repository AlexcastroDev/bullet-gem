Testing eager loading and Bullet gem

# Logs

```bash
➜  bullet git:(main) ✗ ruby app.rb
Run options: --seed 22888

# Running:

D, [2024-05-17T02:56:01.537037 #50948] DEBUG -- :   Order Load (0.1ms)  SELECT "orders".* FROM "orders" ORDER BY "orders"."id" ASC LIMIT ?  [["LIMIT", 1]]
D, [2024-05-17T02:56:01.537843 #50948] DEBUG -- :   OrderItem Load (0.1ms)  SELECT "order_items".* FROM "order_items" WHERE "order_items"."order_id" = ?  [["order_id", 1]]
D, [2024-05-17T02:56:01.539608 #50948] DEBUG -- :   TRANSACTION (0.0ms)  begin transaction
D, [2024-05-17T02:56:01.539698 #50948] DEBUG -- :   OrderItem Update (0.1ms)  UPDATE "order_items" SET "name" = ?, "quantity" = ? WHERE "order_items"."id" = ?  [["name", "item d"], ["quantity", 6], ["id", 1]]
D, [2024-05-17T02:56:01.539765 #50948] DEBUG -- :   TRANSACTION (0.0ms)  commit transaction
item d
D, [2024-05-17T02:56:01.539951 #50948] DEBUG -- :   TRANSACTION (0.0ms)  begin transaction
D, [2024-05-17T02:56:01.539991 #50948] DEBUG -- :   OrderItem Update (0.0ms)  UPDATE "order_items" SET "name" = ?, "quantity" = ? WHERE "order_items"."id" = ?  [["name", "item g"], ["quantity", 4], ["id", 2]]
D, [2024-05-17T02:56:01.540030 #50948] DEBUG -- :   TRANSACTION (0.0ms)  commit transaction
item g
D, [2024-05-17T02:56:01.540181 #50948] DEBUG -- :   TRANSACTION (0.0ms)  begin transaction
D, [2024-05-17T02:56:01.540218 #50948] DEBUG -- :   OrderItem Update (0.0ms)  UPDATE "order_items" SET "name" = ?, "quantity" = ? WHERE "order_items"."id" = ?  [["name", "item c"], ["quantity", 7], ["id", 3]]
D, [2024-05-17T02:56:01.540257 #50948] DEBUG -- :   TRANSACTION (0.0ms)  commit transaction
item c
.

Finished in 0.013922s, 71.8288 runs/s, 0.0000 assertions/s.
```