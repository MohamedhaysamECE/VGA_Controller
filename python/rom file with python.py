with open('output_image.txt', 'r') as f:
    lines = f.readlines()

verilog_rom = []
for line in lines:
    verilog_rom.append(line.strip())

# Generate Verilog code
with open('rom_data.v', 'w') as f:
    f.write('module rom (\n')
    f.write('    input wire [15:0] addr,\n')
    f.write('    output reg [2:0] data\n')
    f.write(');\n\n')
    f.write('    reg [2:0] rom_memory [0:40800];  // 340 * 120 = 40800\n\n')
    f.write('    initial begin\n')
    for i, value in enumerate(verilog_rom):
        f.write(f'        rom_memory[{i}] = 3\'b{value};\n')
    f.write('    end\n\n')
    f.write('    always @(*) begin\n')
    f.write('        data = rom_memory[addr];\n')
    f.write('    end\n')
    f.write('endmodule\n')