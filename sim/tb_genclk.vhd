----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/17 10:26:32
-- Design Name: 
-- Module Name: tb_genclk - Behavioral
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

entity tb_genclk is
    generic(
            PERIOD : time :=10 ns
            );
    Port ( CLK : out STD_LOGIC);
end tb_genclk;

architecture Behavioral of tb_genclk is

constant clk_period : time := 10 ns;
signal sig_clk  :std_logic;

begin


  process
  begin
  sig_clk <= '0';
  
    loop
        wait for clk_period/2;
        sig_clk <= not sig_clk;
    end loop;
  end process;
  

  
  CLK <= sig_clk;

end Behavioral;
