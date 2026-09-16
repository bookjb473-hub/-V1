import 'package:flutter/material.dart';

void main() {
  runApp(const EggPamApp());
}

class EggPamApp extends StatelessWidget {
  const EggPamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เครื่องเก็บไข่ผำ มรพส.',
      theme: ThemeData(
        primaryColor: const Color(0xFF007A33), // สีเขียว มรพส.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007A33),
          secondary: const Color(0xFFEAAA00), // สีทอง มรพส.
        ),
        useMaterial3: true,
      ),
      home: const ControllerPage(),
    );
  }
}

class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  String currentStatus = "รอการเชื่อมต่อบลูทูธ (ESP32)";
  bool isConnected = false;

  void sendCommand(String command, String actionName) {
    setState(() {
      currentStatus = "กำลังส่งคำสั่ง: $command ($actionName)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('เครื่องเก็บไข่ผำ Controller', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text('มหาวิทยาลัยราชภัฏพิบูลสงคราม พิษณุโลก', style: TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF007A33),
        elevation: 4,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                // แถบไฟวิ่งเอฟเฟกต์ RGB สวยงามด้านบนแอป
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red, Colors.orange, Colors.yellow, 
                        Colors.green, Colors.blue, Colors.purple, Colors.red
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // การ์ดแสดงชื่อสถาบันและโปรเจกต์
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "PROJECT: เครื่องเก็บไข่ผำด้วยใบพัด",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF007A33)),
                        ),
                        const Text(
                          "มหาวิทยาลัยราชภัฏพิบูลสงคราม พิษณุโลก",
                          style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        const Divider(height: 25),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isConnected = !isConnected;
                              currentStatus = isConnected ? "เชื่อมต่อกับ ESP32 สำเร็จ" : "ตัดการเชื่อมต่อบลูทูธแล้ว";
                            });
                          },
                          icon: Icon(isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled),
                          label: Text(isConnected ? 'เชื่อมต่อสำเร็จแล้ว' : 'กดเพื่อเชื่อมต่อบลูทูธ'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isConnected ? Colors.blue.shade600 : Colors.grey.shade800,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(currentStatus, style: TextStyle(color: isConnected ? Colors.green.shade700 : Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // แผงปุ่มกดคุมใบพัดขับเคลื่อน
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(color: Colors.cyan.withOpacity(0.15), blurRadius: 10, spreadRadius: 2),
                        BoxShadow(color: Colors.magenta.withOpacity(0.15), blurRadius: 10, spreadRadius: 2),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          const Text('แผงควบคุมการขับเคลื่อนมอเตอร์', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54)),
                          const SizedBox(height: 20),
                          
                          // เดินหน้า
                          InkWell(
                            onTap: () => sendCommand("F", "เดินหน้า"),
                            child: Icon(Icons.arrow_circle_up_rounded, size: 85, color: const Color(0xFF007A33).withOpacity(0.9)),
                          ),
                          // ซ้าย ขวา
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => sendCommand("L", "เลี้ยวซ้าย"),
                                child: const Icon(Icons.arrow_circle_left_rounded, size: 85, color: Color(0xFF007A33)),
                              ),
                              const SizedBox(width: 45),
                              InkWell(
                                onTap: () => sendCommand("R", "เลี้ยวขวา"),
                                child: const Icon(Icons.arrow_circle_right_rounded, size: 85, color: Color(0xFF007A33)),
                              ),
                            ],
                          ),
                          // ถอยหลัง
                          InkWell(
                            onTap: () => sendCommand("B", "ถอยหลัง"),
                            child: Icon(Icons.arrow_circle_down_rounded, size: 85, color: const Color(0xFF007A33).withOpacity(0.9)),
                          ),
                          const SizedBox(height: 25),
                          
                          // ปุ่มหยุดการทำงาน (STOP)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: ElevatedButton.icon(
                              onPressed: () => sendCommand("S", "หยุดทำงาน"),
                              icon: const Icon(Icons.dangerous, size: 26),
                              label: const Text('หยุดเครื่อง (STOP)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(55),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
