----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/13 18:16:48
-- Design Name: 
-- Module Name: dist_ram_w16_r8 - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DistributedRAM_w128_r128 is
    port (
        -- 書き込みポート
        write_clk : in std_logic;
        write_en  : in std_logic;
        write_addr: in unsigned(7 downto 0);
        write_data: in unsigned(127 downto 0);
        
        -- 読み出しポート
        read_clk  : in std_logic;
        read_en   : in std_logic;
        read_addr : in unsigned(7 downto 0);
        read_data : out unsigned(7 downto 0)
    );
end entity DistributedRAM_w128_r128;

architecture Behavioral of DistributedRAM_w128_r128 is
    type ram_type is array (0 to 15) of unsigned(127 downto 0);
    signal ram : ram_type;
    signal read_data_sig :unsigned(127 downto 0);
begin
    -- 書き込みプロセス
    process(write_clk)
    begin
        if rising_edge(write_clk) then
            if write_en = '1' then
          --      if to_integer(write_addr) < 255 then
                    ram(to_integer(write_addr(7 downto 4))) <= write_data;
          --      end if;
            end if;
        end if;
    end process;
        
    -- 読み出しプロセス

    read_data_sig <= ram(to_integer(read_addr(7 downto 4)));
                    
    
 
read_data <= read_data_sig( 7 downto    0) when read_addr(3 downto 0) = "0000" else
             read_data_sig( 15 downto   8) when read_addr(3 downto 0) = "0001" else
             read_data_sig( 23 downto  16) when read_addr(3 downto 0) = "0010" else
             read_data_sig( 31 downto  24) when read_addr(3 downto 0) = "0011" else
             read_data_sig( 39 downto  32) when read_addr(3 downto 0) = "0100" else
             read_data_sig( 47 downto  40) when read_addr(3 downto 0) = "0101" else
             read_data_sig( 55 downto  48) when read_addr(3 downto 0) = "0110" else
             read_data_sig( 63 downto  56) when read_addr(3 downto 0) = "0111" else
             read_data_sig( 71 downto  64) when read_addr(3 downto 0) = "1000" else
             read_data_sig( 79 downto  72) when read_addr(3 downto 0) = "1001" else
             read_data_sig( 87 downto  80) when read_addr(3 downto 0) = "1010" else
             read_data_sig( 95 downto  88) when read_addr(3 downto 0) = "1011" else
             read_data_sig(103 downto  96) when read_addr(3 downto 0) = "1100" else
             read_data_sig(111 downto 104) when read_addr(3 downto 0) = "1101" else
             read_data_sig(119 downto 112) when read_addr(3 downto 0) = "1110" else
             read_data_sig(127 downto 120) ;    
    
    
end architecture Behavioral;


