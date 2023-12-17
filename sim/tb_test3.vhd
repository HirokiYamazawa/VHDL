----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/17 09:59:03
-- Design Name: 
-- Module Name: tb_test3 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_test3 is
--  Port ( );
end tb_test3;

architecture Behavioral of tb_test3 is

    signal S_AXIS_0_tdata : STD_LOGIC_VECTOR ( 63 downto 0 );
    signal S_AXIS_0_tkeep : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal S_AXIS_0_tlast : STD_LOGIC;
    signal S_AXIS_0_tready : STD_LOGIC;
    signal S_AXIS_0_tvalid :STD_LOGIC;
    
    signal s_aclk_0 : STD_LOGIC;
    signal s_aresetn_0 : STD_LOGIC;
    
    signal ready:STD_LOGIC_VECTOR ( 0 to 0 );
    
    
      -- Define your data array
      type data_array is array (0 to 7) of std_logic_vector(63 downto 0);
      constant my_data : data_array := (
        X"0000000000000000",
        X"0000000200000001",
        X"0000000400000003",
        X"0000000600000005",
        X"0000000800000007",
        X"0000000A00000009",
        X"0000000C0000000B",
        X"0000000E0000000D"
      );
      
      
        
  -- Procedure to send data
  procedure send_data(
    data            : in std_logic_vector ;
    last            : in std_logic;
    signal S_AXIS_0_tdata   : out STD_LOGIC_VECTOR ( 63 downto 0 );
    signal S_AXIS_0_tkeep   : out STD_LOGIC_VECTOR ( 7 downto 0 );
    signal S_AXIS_0_tlast   : out STD_LOGIC;
    signal S_AXIS_0_tvalid  : out STD_LOGIC
  ) is
  begin
  
    S_AXIS_0_tdata  <= data;
    S_AXIS_0_tkeep  <= "11111111";
    S_AXIS_0_tvalid <= '1';
    S_AXIS_0_tlast  <= last;
    wait for 10 ns;
    S_AXIS_0_tvalid <= '0';
    wait for 10 ns;
  end procedure;


  procedure send_packet(
    data             : in data_array ;    
    signal S_AXIS_0_tdata   : out STD_LOGIC_VECTOR ( 63 downto 0 );
    signal S_AXIS_0_tkeep   : out STD_LOGIC_VECTOR ( 7 downto 0 );
    signal S_AXIS_0_tlast   : out STD_LOGIC;
    signal S_AXIS_0_tvalid  : out STD_LOGIC
  ) is
    variable tmp : std_logic_vector(63 downto 0);
  begin
  
    -- プロシージャを使用してデータを送信
    for i in 0 to 7 loop
    
    if i = 7 then
      -- iが7の場合に固定のデータを送信
         send_data(data(i),
         '1',
         S_AXIS_0_tdata,
         S_AXIS_0_tkeep   ,
         S_AXIS_0_tlast   ,
         S_AXIS_0_tvalid  );
    else
      -- 通常のデータを送信
          send_data(data(i),
         '0',
         S_AXIS_0_tdata,
         S_AXIS_0_tkeep   ,
         S_AXIS_0_tlast   ,
         S_AXIS_0_tvalid  
      );
     end if;

      
      wait for 10ns;
    end loop;
  
  end procedure;



begin

CLK : entity work.tb_genclk
    generic map(
        PERIOD => 10 ns
        )
    port map(
        CLK => s_aclk_0
    );
    
uut : entity work.tb_reset
        generic map (
            RESET_TIME => 50 ns  -- テスト用のリセット時間
        )
        port map (
            clk   => s_aclk_0,
            rst_n => s_aresetn_0
        );
        
DUT : entity work.TB_myTB_wrapper
    port map(
    S_AXIS_0_tdata => S_AXIS_0_tdata,
    S_AXIS_0_tready=> S_AXIS_0_tready,
    S_AXIS_0_tvalid=>S_AXIS_0_tvalid ,
    ready=> ready,
    s_aclk_0=> s_aclk_0,
    s_aresetn_0=> s_aresetn_0
    );

process
begin
    
    wait for 100ns;
    
    send_packet(my_data,
         S_AXIS_0_tdata,
         S_AXIS_0_tkeep,
         S_AXIS_0_tlast,
         S_AXIS_0_tvalid  );
         
    wait for 100ns;
    ready(0) <= '1';
    wait;
    
end process;
end Behavioral;
