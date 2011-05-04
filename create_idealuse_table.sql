--
-- Name: op_inv_ideal_use; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE op_inv_ideal_use (
    turn_date date NOT NULL,
    turn_id smallint NOT NULL,
    inv_id character(6) NOT NULL,
    ideal_use numeric(12,2),
    unit_cost numeric(12,2),
    misc boolean
);


ALTER TABLE public.op_inv_ideal_use OWNER TO postgres;

--
-- Name: op_invc_ideal_use_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY op_inv_ideal_use
    ADD CONSTRAINT op_invc_ideal_use_pkey PRIMARY KEY (turn_date, turn_id, inv_id);


--
-- Name: fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY op_inv_ideal_use
    ADD CONSTRAINT fk1 FOREIGN KEY (inv_id) REFERENCES op_grl_cat_inventory(inv_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

