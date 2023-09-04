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

entity DistributedRAM_w64_r64 is
    port (
        -- �������݃|�[�g
        write_clk : in std_logic;
        write_en  : in std_logic;
        write_addr: in unsigned(7 downto 0);
        write_data: in unsigned(63 downto 0);
        
        -- �ǂݏo���|�[�g
        read_clk  : in std_logic;
        read_en   : in std_logic;
        read_addr : in unsigned(7 downto 0);
        read_data : out unsigned(7 downto 0)
    );
end entity DistributedRAM_w64_r64;

architecture Behavioral of DistributedRAM_w64_r64 is
    type ram_type is array (0 to 31) of unsigned(63 downto 0);
    signal ram : ram_type;
    signal read_data_sig :unsigned(63 downto 0);
begin
    -- �������݃v���Z�X
    process(write_clk)
    begin
        if rising_edge(write_clk) then
            if write_en = '1' then
          --      if to_integer(write_addr) < 255 then
                    ram(to_integer(write_addr(7 downto 3))) <= write_data;
          --      end if;
            end if;
        end if;
    end process;
        
    -- �ǂݏo���v���Z�X
    process(read_clk)
    begin
        if rising_edge(read_clk) then
            if read_en = '1' then
              read_data_sig <= ram(to_integer(read_addr(7 downto 3)));
                
            end if;
        end if;
    end process;
    
 
read_data <= read_data_sig(7 downto 0)   when read_addr(2 downto 0) = "000" else
             read_data_sig(15 downto 8)  when read_addr(2 downto 0) = "001" else
             read_data_sig(23 downto 16) when read_addr(2 downto 0) = "010" else
             read_data_sig(31 downto 24) when read_addr(2 downto 0) = "011" else
             read_data_sig(39 downto 32) when read_addr(2 downto 0) = "100" else
             read_data_sig(47 downto 40) when read_addr(2 downto 0) = "101" else
             read_data_sig(55 downto 48) when read_addr(2 downto 0) = "110" else
             read_data_sig(63 downto 56) ;    
    
    
end architecture Behavioral;


