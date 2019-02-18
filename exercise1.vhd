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

--declare mux entity
entity mux2to1 is
port ( A, B: in std_logic_vector(7 downto 0);
        sel: in std_logic;
        muxOut: out std_logic_vector(7 downto 0));
end mux2to1;

--declare mux architecture
architecture my_mux of mux2to1 is
begin
--declare mux
with sel select
    muxOut <= A when '1',
              B when '0',
             (others => '0') when others;
end my_mux;   

--redeclare library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declare regA entity
entity Reg_A is
port ( reg_IN: in std_logic_vector(7 downto 0);
        LD, CLK: in std_logic;
        reg_OUT: out std_logic_vector(7 downto 0));
end Reg_A;

--declare register architecture
architecture my_REG of reg_A is
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--declare full entity
entity exercise1 is
 Port ( A, B: in std_logic_vector(7 downto 0);
        clk, sel : in std_logic;
        lda : in std_logic;
        F: out std_logic_vector(7 downto 0));
        
end exercise1;
--define architecture
architecture Behavioral of exercise1 is


--declare components

--declare mux
component mux2to1
    Port ( A, B: in std_logic_vector(7 downto 0);
           sel: in std_logic;
           muxOut: out std_logic_vector(7 downto 0));
end component mux2to1;

--declare registerA
component REG_A
    Port ( reg_IN: in std_logic_vector(7 downto 0);
           clk, LD: in std_logic;
           reg_OUT: out std_logic_vector(7 downto 0));
end component REG_A;   

--intermidiate signal
signal muxOut : std_logic_vector(7 downto 0); 

begin

    mux: mux2to1 port map( A => A,
                           B => B,
                           sel => sel,
                           muxOut => muxOut);
                           
   reg: REG_A port map( reg_IN => muxout,
                        clk => clk,
                        LD => lda,
                        reg_OUT => F);


end Behavioral;
