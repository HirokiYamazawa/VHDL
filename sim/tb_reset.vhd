----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/17 17:25:30
-- Design Name: 
-- Module Name: tb_reset - Behavioral
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

entity tb_reset is
    generic (
        RESET_TIME : time := 10 ns  -- デフォルトのリセット時間
    );
    port (
        clk    : in  std_logic;
        rst_n  : out std_logic
    );
    
    end tb_reset;

architecture Behavioral of tb_reset is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- リセット信号の生成
            if now <= RESET_TIME then
                rst_n <= '0';
            else
                rst_n <= '1';
            end if;
        end if;
    end process;
end Behavioral;

