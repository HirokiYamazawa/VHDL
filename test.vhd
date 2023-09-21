----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/09/17 12:01:53
-- Design Name: 
-- Module Name: MDS_io_8bit - Behavioral
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

entity MDS_io_8bit is
  Port ( 
        -- param
        input_param       : in std_logic_vector(63 downto 0);
        -- mds
        input_data  : in std_logic_vector( 7 downto 0);
        output_data : out std_logic_vector( 7 downto 0)  
  );
end MDS_io_8bit;

architecture Behavioral of MDS_io_8bit is

type ArrayType is array(0 to 7, 7 downto 0) of STD_LOGIC;
signal param : ArrayType;


begin

    process(input_data)
    begin
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                param(i,j) <= input_param(63 - (i*8+j));
            end loop;
        end loop;
    end process;


    process(input_data)
    begin
        for i in 0 to 7 loop
            output_data(i) <= 
                (param(i,0) and input_data(0))
                xor
                (param(i,1) and input_data(1))
                xor
                (param(i,2) and input_data(2))
                xor
                (param(i,3) and input_data(3))
                xor
                (param(i,4) and input_data(4))
                xor
                (param(i,5) and input_data(5))
                xor
                (param(i,6) and input_data(6))
                xor
                (param(i,7) and input_data(7));
        end loop;
    end process;
    
end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/09/17 12:51:06
-- Design Name: 
-- Module Name: MDS_IO_64bit - Behavioral
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

entity MDS_IO_64bit is
    generic(
    IO_WIDTH    : integer := 64
    );
    Port (         
        -- param
        input_param       : in std_logic_vector(63 downto 0);
        -- mds
        input_data  : in  std_logic_vector( IO_WIDTH -1 downto 0);
        output_data : out std_logic_vector( IO_WIDTH -1 downto 0)  
        );
end MDS_IO_64bit;

architecture Behavioral of MDS_IO_64bit is

type ParamArrayType is array(0 to 7, 7 downto 0) of STD_LOGIC;
signal param : ParamArrayType;

type IOArrayType is array(0 to 7, (IO_WIDTH / 8) -1 downto 0) of STD_LOGIC;
signal Input_array : IOArrayType;
signal Output_array : IOArrayType;


begin
    
    -- 行列式のパラメータ
    process
    begin
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                param(i,j) <= input_param(63 - (i*8+j));
            end loop;
        end loop;
    end process;

    process(input_data)
    begin
        for i in 0 to 7 loop
                output_data(i*8+7 downto i*8) <= 
                    (param(i,0) & param(i,0) & param(i,0) & param(i,0) & param(i,0) & param(i,0) & param(i,0) & param(i,0) and input_data(7 downto 0))
                    xor
                    (param(i,1) & param(i,1) & param(i,1) & param(i,1) & param(i,1) & param(i,1) & param(i,1) & param(i,1) and input_data(15 downto 8))
                    xor
                    (param(i,2) & param(i,2) & param(i,2) & param(i,2) & param(i,2) & param(i,2) & param(i,2) & param(i,2) and input_data(23 downto 16))
                    xor
                    (param(i,3) & param(i,3) & param(i,3) & param(i,3) & param(i,3) & param(i,3) & param(i,3) & param(i,3) and input_data(31 downto 24))
                    xor
                    (param(i,4) & param(i,4) & param(i,4) & param(i,4) & param(i,4) & param(i,4) & param(i,4) & param(i,4) and input_data(39 downto 32))
                    xor
                    (param(i,5) & param(i,5) & param(i,5) & param(i,5) & param(i,5) & param(i,5) & param(i,5) & param(i,5) and input_data(47 downto 40))
                    xor
                    (param(i,6) & param(i,6) & param(i,6) & param(i,6) & param(i,6) & param(i,6) & param(i,6) & param(i,6) and input_data(55 downto 48))
                    xor
                    (param(i,7) & param(i,7) & param(i,7) & param(i,7) & param(i,7) & param(i,7) & param(i,7) & param(i,7) and input_data(63 downto 56));
        end loop;
    end process;



end Behavioral;
