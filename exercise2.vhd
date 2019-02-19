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

--declare mux entity-------------------------------------------
entity mux4to1 is
port ( x, y, z, RB_out: in std_logic_vector(7 downto 0);
        MS: in std_logic_vector(1 downto 0);
        muxOut: out std_logic_vector(7 downto 0));
end mux4to1;

--declare mux architecture
architecture my_mux of mux4to1 is
begin
--declare mux
with MS select
    muxOut <= x when "00",
              y when "01",
              z when "10",
              RB_out when "11",
             (others => '0') when others;
end my_mux;
--end mux------------------------------------------------------


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
entity exercise2 is
 Port ( X, Y, Z: in std_logic_vector(7 downto 0);
        MS : in std_logic_vector (1 downto 0);
        DS, CLK : in std_logic;
        RA, RB: out std_logic_vector(7 downto 0));
        
end exercise2;
--define architecture
architecture Behavioral of exercise2 is


--declare components------------------------------------------------

--declare mux
component mux4to1
   port ( x, y, z, RB_out: in std_logic_vector(7 downto 0);
        ms: in std_logic_vector(1 downto 0);
        muxOut: out std_logic_vector(7 downto 0));
end component mux4to1;


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
signal muxOut, regA_out, regB_out : std_logic_vector(7 downto 0);
signal decoder_out1, decoder_out0: std_logic; 

begin
--declare port maps-------------------------------------------------

--declare mux map
    mux: mux4to1 port map( RB_out => regB_out,
                           x => X,
                           y => Y,
                           z => Z,
                           ms => MS,
                           muxOut => muxOut);


--declare decoder map                           
   dec: decoder1to2 port map(ds => DS,
                             output1 => decoder_out1,
                             output0 => decoder_out0);                        
  
  
--declare regA map                         
   RegA: REG port map( reg_IN => muxout,
                        clk => clk,
                        LD => decoder_out0,
                        reg_OUT => regA_out);
 
 
 --declare regB map                      
   RegB: REG port map( reg_IN => regA_out,
                       clk => clk,
                       LD => decoder_out1,
                       reg_OUT => regB_out);
                       
 --end maps---------------------------------------------------------
                       
 --declare output signals of the full entity
 RA <= regA_out;
 RB <= regB_out;


end Behavioral;
--end full system--------------------------------------------------------