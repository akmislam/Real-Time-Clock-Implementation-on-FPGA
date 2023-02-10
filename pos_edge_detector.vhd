-------------------------------------------------------------------------------
--
-- Title       : pos_edge_detector
-- Design      : Positive_Edge_Detector
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab10\Design Task 1\Positive_Edge_Detector\Positive_Edge_Detector\src\pos_edge_detector.vhd
-- Generated   : Thu Apr 15 20:53:30 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for an entity that detects
--				 positive edges on a signal.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


entity pos_edge_detector is	
	port(
	a: in std_logic;		--input signal
	rst_n: in std_logic;	--asynchronous reset
	clk: in std_logic;		--system clock
	a_pe: out std_logic		--one system clock wide pulse
	);
end pos_edge_detector;


architecture behavior of pos_edge_detector is
	signal a_delayed: std_logic;
begin
	posedge: process (clk)
	begin
		if rst_n = '0' then		-- rst_n is synchronous reset	
			if rising_edge(clk) then
				a_pe <= '0';	   -- clear outputs when asserted (low)
				a_delayed <= '0';
			end if;
		elsif rising_edge(clk) then		-- on pos clock edge
			a_delayed <= a;				-- a delayed gets a for a clock cycle
			a_pe <= not a_delayed and a;-- that one clock cycle when both are
		end if;							-- 1 generates a positive pulse.
	end process;
end behavior;
