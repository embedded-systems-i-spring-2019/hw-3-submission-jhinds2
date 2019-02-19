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

--declare register entity--------------------------------------------------
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
--end register entity------------------------------------------------------


--declare andGate entity---------------------------------------------------
--redeclare library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity andGate is
port(inputA, inputB: in std_logic;
     output: out std_logic);
end entity andGate;

architecture my_AND of andGate is
begin
    process(inputB, inputB)
        begin
            if(inputA = '1' and inputB = '1') then
            output <= '1';
            else
            output <= '0';
            end if;
        end process;
end my_AND;
--end andgate entity-------------------------------------------------------



--declare andGate entity---------------------------------------------------
--redeclare library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter is
port(input: in std_logic;
     output: out std_logic);
end entity inverter;

architecture my_inv of inverter is
begin
    process(input)
        begin
            output <= not input;
        end process;
end my_inv;
--end andgate entity-------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declare full entity
entity exercise4 is
 Port ( X, Y: in std_logic_vector(7 downto 0);
        CLK, S1, S0, RD : in std_logic;
        lDA, LDB : in std_logic;
        RA, RB: out std_logic_vector(7 downto 0));
        
end exercise4;
--define architecture
architecture Behavioral of exercise4 is


--declare components------------------------------------------

--declare mux
component mux2to1
    Port ( input1, input2: in std_logic_vector(7 downto 0);
           sel: in std_logic;
           muxOut: out std_logic_vector(7 downto 0));
end component mux2to1;

--declare register
component REG
    Port ( reg_IN: in std_logic_vector(7 downto 0);
           clk, LD: in std_logic;
           reg_OUT: out std_logic_vector(7 downto 0));
end component REG;


--declare andGate
component andGate
port(inputA, inputB: in std_logic;
     output: out std_logic);
end component andGate;


--declare inverter
component inverter
port(input: in std_logic;
     output: out std_logic);
end component inverter;
--end components----------------------------------------------   

--intermidiate signals
signal mux1_out, mux2_out, RA_out, RB_out : std_logic_vector(7 downto 0); 
signal and1_out, and2_out, not_RD: std_logic;

begin

--port maps-------------------------------------------------------------

    mux1: mux2to1 port map( input1 => X,
                           input2 => Y,
                           sel => S1,
                           muxOut => mux1_out);
                           
    mux2: mux2to1 port map( input1 => RB_out,
                            input2 => Y,
                            sel => S0,
                            muxOut => mux2_out);
   
   inv: inverter port map(input => RD,
                          output => not_RD);                     
                            
   and1: andGate port map(inputA => LDB,
                          inputB => not_RD,
                          output => and1_out);
                          
   and2: andGate port map(inputA => LDA,
                          inputB => RD,
                          output => and2_out);
                           
   RegA: REG port map( reg_IN => mux2_out,
                        clk => clk,
                        LD => and2_out,
                        reg_OUT => RA_out);

   RegB: REG port map( reg_IN => mux1_out,
                        clk => clk,
                        LD => and1_out,
                        reg_OUT => RB_out);
                        
--define output
RA <= RA_out;
RB <= RB_out;

--end maps---------------------------------------------------------------                    
   

end Behavioral;