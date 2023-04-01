----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2023 10:55:20 AM
-- Design Name: 
-- Module Name: debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    port(
        input_btn: in bit;
        clk: in bit;
        output_btn: out bit
    );
end debouncer;

architecture Behavioral of debouncer is
    signal D1, D2, D3: bit;
begin
    process(clk) is
    begin
        if(clk' event and clk='1') then
            D1 <= input_btn;
            D2 <= D1;
            D3 <= D2;
        end if;
    end process;
    output_btn <= D1 and D2 and D3;

end Behavioral;
