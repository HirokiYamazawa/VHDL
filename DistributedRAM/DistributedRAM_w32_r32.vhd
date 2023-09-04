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

entity DistributedRAM_w32_r32 is
    port (
        -- 書き込みポート
        write_clk : in std_logic;
        write_en  : in std_logic;
        write_addr: in unsigned(7 downto 0);
        write_data: in unsigned(31 downto 0);
        
        -- 読み出しポート
        read_clk  : in std_logic;
        read_en   : in std_logic;
        read_addr : in unsigned(7 downto 0);
        read_data : out unsigned(7 downto 0)
    );
end entity DistributedRAM_w32_r32;

architecture Behavioral of DistributedRAM_w32_r32 is
    type ram_type is array (0 to 63) of unsigned(31 downto 0);
    signal ram : ram_type;
    signal read_data_sig :unsigned(31 downto 0);
begin
    -- 書き込みプロセス
    process(write_clk)
    begin
        if rising_edge(write_clk) then
            if write_en = '1' then
          --      if to_integer(write_addr) < 255 then
                    ram(to_integer(write_addr(7 downto 2))) <= write_data;
          --      end if;
            end if;
        end if;
    end process;
        
    -- 読み出しプロセス
    process(read_clk)
    begin
        if rising_edge(read_clk) then
            if read_en = '1' then
              read_data_sig <= ram(to_integer(read_addr(7 downto 2)));
                
            end if;
        end if;
    end process;
    
 
read_data <= read_data_sig(7 downto 0)   when read_addr(1 downto 0) = "00" else
             read_data_sig(15 downto 8)  when read_addr(1 downto 0) = "01" else
             read_data_sig(23 downto 16) when read_addr(1 downto 0) = "10" else
             read_data_sig(31 downto 24) ;    
    
    
end architecture Behavioral;


