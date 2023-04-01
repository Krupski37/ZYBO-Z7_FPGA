----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2023 10:37:50
-- Design Name: 
-- Module Name: first_tb - Behavioral
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

entity first_tb is
--  Port ( );
end first_tb;

architecture Behavioral of first_tb is
    signal C: bit;
    signal Y:  bit_vector(7 downto 0);
    signal btn: bit_vector(3 downto 0);
begin
    process is
    begin
        C <= '0';
        wait for 1ns;
        C <= '1';
        wait for 1ns;        
    end process;
    
    process is
    begin
        btn <= "0000";
        wait for 1000ns;
        btn <= "0010"; -- w³¹cz/wy³¹cz
        wait for 100ns;
        btn <= "0000";
        wait for 1000ns;
        btn <= "1000"; -- uruchomie drugiego scheamtu
        wait for 100ns;
        btn <= "0000";
        wait for 1000ns;
        btn <= "0100"; -- uruchomienie zmiany prêdkoœci
        wait for 100ns;
  
    end process;
    
    inst: entity work.TOP(behavioral)
    port map (
        clk => C,
        btn => btn,
        je => Y
    );
    
end Behavioral;
