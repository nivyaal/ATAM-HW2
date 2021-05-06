#include <asm/desc.h>

void my_store_idt(struct desc_ptr *idtr) {
// <STUDENT FILL>
	asm volatile( "mov %idtr, %0"
			:"=r"(idtr)
			:
			:"%idtr"
			);
// </STUDENT FILL>
}

void my_load_idt(struct desc_ptr *idtr) {
// <STUDENT FILL>
	asm volatile( "mov %0, %idtr"
			:"r"(idtr)
			:
			:"%idtr"
			);
// <STUDENT FILL>
}

void my_set_gate_offset(gate_desc *gate, unsigned long addr) {
// <STUDENT FILL>
	gate->offset_low = PTR_LOW(addr);
	gate->offset_middle = PTR_MIDDLE(addr);
	gate->offset_high = PTR_HIGH(addr);
// </STUDENT FILL>
}

unsigned long my_get_gate_offset(gate_desc *gate) {
// <STUDENT FILL>
	unsigned long offset_high = gate->offset_high << 32;
	unsigned long offset_mid = gate->offset_mid << 16;
	return offset_high + offset_mid + gate->offset_low;
// </STUDENT FILL>
}


