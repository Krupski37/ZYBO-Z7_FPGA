----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2023 16:29:32
-- Design Name: 
-- Module Name: prescaler - Behavioral
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

entity prescaler is
  port(
    clk: in bit;
    speed: in natural;
    out_clk: out bit
  );
end prescaler;

architecture Behavioral of prescaler is
    signal S: natural:=1;
    signal Y: bit;
begin
process(clk) is
    begin
    if(clk' event and clk='1') then
            if(S mod speed = 0) then
            Y <= '1';
            S <= 1;
        else
            Y <= '0';
            S <= S+1;
        end if; 
    end if;
    end process;
    out_clk <= Y;
end Behavioral;
