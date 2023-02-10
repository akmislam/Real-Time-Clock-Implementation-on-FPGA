-------------------------------------------------------------------------------
--
-- Title       : one_sec_counter
-- Design      : One_Second_Counter
-- Author      : Akm Islam
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : E:\ESE382\Lab10\Design Task 3\One_Second_Counter\One_Second_Counter\src\one_sec_counter.vhd
-- Generated   : Fri Apr 16 00:39:19 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is a design description for entity one_sec_counter. 
--				 It instantiates the two lover level entities to create an
--				 entity that generates a one second tick output and a 1Hz
--				 square wave output.
--
-------------------------------------------------------------------------------


-------------------------------pos_edge_detector-------------------------------
-------------------------------------------------------------------------------
--
-- Description : This is a design description for an entity that detects
--				 positive edges on a signal.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;


entity pos_edge_detector1 is	
	port(
	a: in std_logic;		--input signal
	rst_n: in std_logic;	--asynchronous reset
	clk: in std_logic;		--system clock
	a_pe: out std_logic		--one system clock wide pulse
	);
end pos_edge_detector1;


architecture behavior of pos_edge_detector1 is
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


-------------------------------one_sec_prescalar-------------------------------
-------------------------------------------------------------------------------
--
-- Description : This is a design description of entity one_sec_prescalar.
--				 This design will prescale a 32.768kHz signal down to a 1Hz
--				 signal using counting.
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_sec_prescalar is	
	port(
		clk: in std_logic;			-- system clock
		rst_n: in std_logic;		-- active low synchronous reset
		clr_n: std_logic;			-- synchronous clear
		cnt_en: std_logic;			-- count enable
		one_hz: out std_logic;		-- one Hz square wave output
		one_sec_tick: out std_logic	-- one clock wide pulse every sec
	);
end one_sec_prescalar;

architecture behavior of one_sec_prescalar is
begin  
	
	hold_on_one_sec_pls: process(clk) --, cnt_en)  
	variable count: integer := 32767;
	variable tick_count: integer := 0;
	begin
		if rising_edge(clk) then
			if rst_n = '0' then				-- reset condition clears the outputs 
					one_hz <= '0';				-- asynchronously.
					one_sec_tick <= '0';		-- outputs are 0
					count := 32767;				-- counter is reinitialized
				
			elsif clr_n = '0' then
			--	if rising_edge(clk) then	-- clr_n clears the outputs synchronously
					one_hz <= '0';			-- set outputs to 0
					one_sec_tick <= '0';
					count := 32767;			-- reinitialize the counter
			--	end if;
			
	--		elsif rising_edge(clk) then
				elsif cnt_en = '1' then
					case count is
						when 0 =>
							one_hz <= one_hz xor '1';	-- toggle one_hz
							count := 32767;
							one_sec_tick <= '1';
						when 16383 =>
							one_hz <= one_hz xor '1';	-- toggle one_hz
						    one_sec_tick <= '0';
							count := count - 1;
						when others =>
							one_sec_tick <= '0';
							count := count - 1;
					end case;
				else
					one_sec_tick <= '0';
				end if;

		end if;
		
	end process;
	
end behavior;

--------------------------------one_sec_counter--------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library Task4;
use Task4.all;

entity one_sec_counter is
	port(
	f32768hz: in std_logic;			-- 32.768 kHz oscillator input
	clk: in std_logic;				-- 1 MHz clock osc input
	rst_n: in std_logic;			-- active low synchronous reset
	clr_n: in std_logic;			-- synchronous clear input
	one_sec_tick: out std_logic;	-- one sys clock wide pulse each sec
	one_hz: out std_logic			-- one Hz output square wave	
	);
end one_sec_counter;


architecture structure of one_sec_counter is
signal connect: std_logic;
begin
	u0: entity pos_edge_detector port map (a => f32768hz, rst_n => rst_n, clk => clk, a_pe => connect); 
	u1: entity one_sec_prescalar port map (clk => clk, rst_n => rst_n, clr_n => clr_n, cnt_en => connect, one_sec_tick => one_sec_tick, one_hz => one_hz);
end structure;