----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2019 01:14:31 PM
-- Design Name: 
-- Module Name: exercise1 - Behavioral
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

--declare mux entity-------------------------------------------------------
entity mux2to1 is
port ( input1, input2: in std_logic_vector(7 downto 0);
        sel: in std_logic;
        muxOut: out std_logic_vector(7 downto 0));
end mux2to1;

--declare mux architecture
architecture my_mux of mux2to1 is
begin
--declare mux
with sel select
    muxOut <= input1 when '1',
              input2 when '0',
             (others => '0') when others;
end my_mux;   
--end mux entity-----------------------------------------------------------


--redeclare library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declare 1:2 decoder entity-----------------------------------
entity decoder1to2 is
port ( ds: in std_logic;
        output1, output0: out std_logic);
end decoder1to2;

--declare decoder architecture
architecture decoder of decoder1to2 is
begin

--declare the process of the decoder
process(ds) is
begin
    if(ds = '0') then
        output1 <= '1';
        output0 <= '0';
    elsif (ds = '1') then
        output1 <= '0';
        output0 <= '1';
    else
        output1 <= '0';
        output0 <= '0';
    end if;
end process;

end decoder;
--end decoder---------------------------------------------------




--redeclare library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declare reg entity--------------------------------------------
--this should be able to be used for both REG_A and REG_B
entity REG is
port ( reg_IN: in std_logic_vector(7 downto 0);
        LD, CLK: in std_logic;
        reg_OUT: out std_logic_vector(7 downto 0));
end REG;

--declare register architecture
architecture my_REG of REG is
begin

--process
process(clk)
begin
    if(rising_edge(clk)) then
        if(ld = '1') then
            reg_out <= reg_in;
        end if;
    end if;
end process;
end my_reg; 
--end register-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--declare full entity------------------------------------------
entity exercise5 is
 Port ( A, B, C: in std_logic_vector(7 downto 0);
        SL1, SL2 : in std_logic;
        CLK : in std_logic;
        RAX, RBX: out std_logic_vector(7 downto 0));
        
end exercise5;
--define architecture
architecture Behavioral of exercise5 is


--declare components------------------------------------------------

--declare mux
component mux2to1
    Port ( input1, input2: in std_logic_vector(7 downto 0);
           sel: in std_logic;
           muxOut: out std_logic_vector(7 downto 0));
end component mux2to1;


--declare decoder
component decoder1to2
port ( ds: in std_logic;
        output1, output0: out std_logic);
end component decoder1to2;


--declare register
component REG
    Port ( reg_IN: in std_logic_vector(7 downto 0);
           clk, LD: in std_logic;
           reg_OUT: out std_logic_vector(7 downto 0));
end component REG;   
--end component declarations----------------------------------------


--intermidiate signals
signal muxOutput, regA_out, regB_out : std_logic_vector(7 downto 0);
signal decoder_out1, decoder_out0: std_logic; 

begin
--declare port maps-------------------------------------------------

--declare mux map
   mux: mux2to1 port map( input1 => B,
                           input2 => C,
                           sel => SL2,
                           muxOut => muxOutput);


--declare decoder map                           
   dec: decoder1to2 port map(ds => SL1,
                             output1 => decoder_out1,
                             output0 => decoder_out0);                        
  
  
--declare regA map                         
   RegA: REG port map( reg_IN => A,
                        clk => clk,
                        LD => decoder_out1,
                        reg_OUT => regA_out);
 
 
 --declare regB map                      
   RegB: REG port map( reg_IN => muxOutput,
                       clk => clk,
                       LD => decoder_out0,
                       reg_OUT => regB_out);
                       
 --end maps---------------------------------------------------------
                       
 --declare output signals of the full entity
 RAX <= regA_out;
 RBX <= regB_out;


end Behavioral;
--end full system--------------------------------------------------------