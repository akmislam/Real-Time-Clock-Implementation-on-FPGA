-------------------------------------------------------------------------------
--
-- Title       : s_r_flip_flop
-- Design      : Task3
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab11\Task 3\Task3\Task3\src\s_r_flip_flop.vhd
-- Generated   : Sun Apr 25 22:27:31 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for an SR flip-flop. This is a
--				 an entity to be implemented into the full RTC parallel load
--				 entity.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity s_r_flip_flop is
	port(
		s : in std_logic; 		-- set input
		r : in std_logic; 		-- reset input
		clk : in std_logic; 	-- system clock
		rst_n : in std_logic; 	-- synchronous SET of FF
		q : out std_logic 		-- FF output
	);
end s_r_flip_flop;


architecture behavior of s_r_flip_flop is
begin
	SR_ff: process (clk)
	begin	
		if rising_edge(clk) then
			if rst_n = '0' then
				q <= '1';			
			elsif s = '1' then
				q <= '1';
			elsif r = '1' then
				q <= '0';
		   	end if;
		
		end if;
		
	end process;
	
end behavior;
