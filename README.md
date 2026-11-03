# Logistics Simulator (Ada)

A concurrent warehouse simulation written in Ada. Robots move goods, the unloading zone receives deliveries, and a monitor tracks the state of the whole system.

## Modules

| File | Purpose |
|------|---------|
| `main.adb` | entry point, starts the simulation |
| `common.ads/adb` | shared types and constants |
| `warehouse.ads/adb` | warehouse and its state |
| `robots.ads/adb` | robots moving goods |
| `unloading.ads/adb` | delivery unloading |
| `monitor.ads/adb` | simulation state monitoring and logging |
