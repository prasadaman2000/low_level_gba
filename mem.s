	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"mem.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.comm	size_allocated,4,4
	.comm	mem_block_size,4,4
	.comm	num_alloced_blocks,4,4
	.global	block_arr
	.data
	.align	2
	.type	block_arr, %object
	.size	block_arr, 4
block_arr:
	.word	33812480
	.text
	.align	1
	.global	mem_init
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	mem_init, %function
mem_init:
.LFB0:
	.file 1 "mem.c"
	.loc 1 29 16
	.cfi_startproc
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	.cfi_offset 14, -4
	sub	sp, sp, #8
	.cfi_def_cfa_offset 16
	add	r7, sp, #0
	.cfi_def_cfa_register 7
.LBB2:
	.loc 1 31 13
	movs	r3, #0
	str	r3, [r7, #4]
	.loc 1 31 5
	b	.L2
.L3:
	.loc 1 32 19 discriminator 3
	ldr	r3, .L4
	ldr	r3, [r3]
	.loc 1 32 39 discriminator 3
	ldr	r2, [r7, #4]
	lsls	r2, r2, #3
	movs	r1, #0
	str	r1, [r2, r3]
	.loc 1 31 41 discriminator 3
	ldr	r3, [r7, #4]
	adds	r3, r3, #1
	str	r3, [r7, #4]
.L2:
	.loc 1 31 5 discriminator 1
	ldr	r2, [r7, #4]
	movs	r3, #200
	lsls	r3, r3, #1
	cmp	r2, r3
	blt	.L3
.LBE2:
	.loc 1 36 15
	ldr	r3, .L4
	ldr	r3, [r3]
	.loc 1 36 36
	movs	r2, #252
	lsls	r2, r2, #10
	str	r2, [r3, #4]
	.loc 1 37 15
	ldr	r3, .L4
	ldr	r3, [r3]
	.loc 1 37 35
	movs	r2, #128
	lsls	r2, r2, #18
	str	r2, [r3]
	.loc 1 40 20
	ldr	r3, .L4+4
	movs	r2, #0
	str	r2, [r3]
	.loc 1 41 24
	ldr	r3, .L4+8
	movs	r2, #0
	str	r2, [r3]
	.loc 1 42 1
	nop
	mov	sp, r7
	add	sp, sp, #8
	@ sp needed
	pop	{r7}
	pop	{r0}
	bx	r0
.L5:
	.align	2
.L4:
	.word	block_arr
	.word	size_allocated
	.word	num_alloced_blocks
	.cfi_endproc
.LFE0:
	.size	mem_init, .-mem_init
	.global	__aeabi_idivmod
	.global	__aeabi_idiv
	.align	1
	.global	malloc
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	malloc, %function
malloc:
.LFB1:
	.loc 1 48 36
	.cfi_startproc
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r7, lr}
	.cfi_def_cfa_offset 12
	.cfi_offset 4, -12
	.cfi_offset 7, -8
	.cfi_offset 14, -4
	sub	sp, sp, #44
	.cfi_def_cfa_offset 56
	add	r7, sp, #0
	.cfi_def_cfa_register 7
	str	r0, [r7, #4]
	.loc 1 52 51
	ldr	r3, [r7, #4]
	movs	r2, #3
	ands	r3, r2
	.loc 1 52 12
	movs	r2, #4
	subs	r3, r2, r3
	str	r3, [r7, #28]
	.loc 1 56 7
	ldr	r3, [r7, #28]
	cmp	r3, #4
	beq	.L7
	.loc 1 57 23
	ldr	r2, [r7, #4]
	ldr	r3, [r7, #28]
	adds	r3, r2, r3
	str	r3, [r7, #4]
.L7:
	.loc 1 64 12
	ldr	r3, [r7, #4]
	adds	r3, r3, #4
	str	r3, [r7, #24]
.LBB3:
	.loc 1 66 13
	movs	r3, #0
	str	r3, [r7, #36]
	.loc 1 66 5
	b	.L8
.L14:
	.loc 1 68 9
	ldr	r3, [r7, #36]
	movs	r1, #160
	movs	r0, r3
	bl	__aeabi_idivmod
.LVL0:
	movs	r3, r1
	movs	r4, r3
	ldr	r3, [r7, #36]
	movs	r1, #80
	movs	r0, r3
	bl	__aeabi_idiv
.LVL1:
	movs	r3, r0
	movs	r1, r3
	ldr	r3, .L15
	movs	r2, r3
	movs	r0, r4
	bl	draw_pixel
	.loc 1 71 28
	ldr	r3, .L15+4
	ldr	r2, [r3]
	.loc 1 71 14
	ldr	r3, [r7, #36]
	lsls	r3, r3, #3
	adds	r3, r2, r3
	str	r3, [r7, #20]
	.loc 1 73 17
	ldr	r3, [r7, #20]
	ldr	r3, [r3, #4]
	movs	r2, r3
	.loc 1 73 11
	ldr	r3, [r7, #24]
	cmp	r3, r2
	bcs	.L9
.LBB4:
	.loc 1 78 20
	ldr	r3, [r7, #20]
	ldr	r3, [r3]
	str	r3, [r7, #12]
	.loc 1 81 40
	ldr	r3, [r7, #20]
	ldr	r2, [r3]
	.loc 1 81 47
	ldr	r3, [r7, #24]
	adds	r2, r2, r3
	.loc 1 81 25
	ldr	r3, [r7, #20]
	str	r2, [r3]
	.loc 1 82 26
	ldr	r3, [r7, #20]
	ldr	r3, [r3, #4]
	movs	r2, r3
	ldr	r3, [r7, #24]
	subs	r3, r2, r3
	movs	r2, r3
	ldr	r3, [r7, #20]
	str	r2, [r3, #4]
	.loc 1 85 39
	ldr	r3, [r7, #12]
	ldr	r2, [r7, #4]
	str	r2, [r3]
	.loc 1 88 41
	ldr	r3, [r7, #12]
	adds	r3, r3, #4
	b	.L10
.L9:
.LBE4:
	.loc 1 89 24
	ldr	r3, [r7, #20]
	ldr	r3, [r3, #4]
	movs	r2, r3
	.loc 1 89 18
	ldr	r3, [r7, #24]
	cmp	r3, r2
	bne	.L11
.LBB5:
	.loc 1 91 20
	ldr	r3, [r7, #20]
	ldr	r3, [r3]
	str	r3, [r7, #16]
	.loc 1 94 17
	movs	r3, #0
	str	r3, [r7, #32]
	.loc 1 95 19
	ldr	r3, [r7, #36]
	str	r3, [r7, #32]
	.loc 1 95 13
	b	.L12
.L13:
	.loc 1 96 55 discriminator 3
	ldr	r3, .L15+4
	ldr	r1, [r3]
	.loc 1 96 70 discriminator 3
	ldr	r3, [r7, #32]
	adds	r2, r3, #1
	.loc 1 96 27 discriminator 3
	ldr	r3, .L15+4
	ldr	r0, [r3]
	.loc 1 96 43 discriminator 3
	ldr	r3, [r7, #32]
	lsls	r3, r3, #3
	lsls	r2, r2, #3
	adds	r3, r0, r3
	adds	r2, r1, r2
	ldmia	r2!, {r0, r1}
	stmia	r3!, {r0, r1}
	.loc 1 95 49 discriminator 3
	ldr	r3, [r7, #32]
	adds	r3, r3, #1
	str	r3, [r7, #32]
.L12:
	.loc 1 95 13 discriminator 1
	ldr	r2, [r7, #32]
	movs	r3, #199
	lsls	r3, r3, #1
	cmp	r2, r3
	ble	.L13
	.loc 1 99 23
	ldr	r3, .L15+4
	ldr	r3, [r3]
	.loc 1 99 43
	ldr	r2, [r7, #32]
	lsls	r2, r2, #3
	movs	r1, #0
	str	r1, [r2, r3]
	.loc 1 100 23
	ldr	r3, .L15+4
	ldr	r2, [r3]
	.loc 1 100 44
	ldr	r3, [r7, #32]
	lsls	r3, r3, #3
	adds	r3, r2, r3
	adds	r3, r3, #4
	movs	r2, #0
	str	r2, [r3]
	.loc 1 103 41
	ldr	r3, [r7, #16]
	ldr	r2, [r7, #4]
	str	r2, [r3]
	.loc 1 106 43
	ldr	r3, [r7, #16]
	adds	r3, r3, #4
	b	.L10
.L11:
.LBE5:
	.loc 1 66 41 discriminator 2
	ldr	r3, [r7, #36]
	adds	r3, r3, #1
	str	r3, [r7, #36]
.L8:
	.loc 1 66 5 discriminator 1
	ldr	r2, [r7, #36]
	movs	r3, #200
	lsls	r3, r3, #1
	cmp	r2, r3
	blt	.L14
.LBE3:
	.loc 1 109 12
	movs	r3, #0
.L10:
	.loc 1 110 1
	movs	r0, r3
	mov	sp, r7
	add	sp, sp, #44
	@ sp needed
	pop	{r4, r7}
	pop	{r1}
	bx	r1
.L16:
	.align	2
.L15:
	.word	65535
	.word	block_arr
	.cfi_endproc
.LFE1:
	.size	malloc, .-malloc
	.align	1
	.global	free
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	free, %function
free:
.LFB2:
	.loc 1 117 22
	.cfi_startproc
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	.cfi_offset 14, -4
	sub	sp, sp, #32
	.cfi_def_cfa_offset 40
	add	r7, sp, #0
	.cfi_def_cfa_register 7
	str	r0, [r7, #4]
	.loc 1 119 12
	ldr	r3, [r7, #4]
	subs	r3, r3, #4
	str	r3, [r7, #24]
	.loc 1 122 12
	ldr	r3, [r7, #24]
	ldr	r3, [r3]
	str	r3, [r7, #20]
	.loc 1 125 12
	ldr	r2, [r7, #24]
	ldr	r3, [r7, #20]
	adds	r3, r2, r3
	str	r3, [r7, #16]
	.loc 1 129 19
	movs	r3, #30
	adds	r3, r7, r3
	movs	r2, #0
	strh	r2, [r3]
	.loc 1 129 5
	b	.L18
.L19:
.LBB6:
	.loc 1 130 44
	ldr	r3, .L20
	ldr	r2, [r3]
	.loc 1 130 56
	movs	r1, #30
	adds	r3, r7, r1
	ldrh	r3, [r3]
	.loc 1 130 21
	lsls	r3, r3, #3
	adds	r3, r2, r3
	str	r3, [r7, #12]
.LBE6:
	.loc 1 129 61
	adds	r3, r7, r1
	ldrh	r2, [r3]
	adds	r3, r7, r1
	adds	r2, r2, #1
	strh	r2, [r3]
.L18:
	.loc 1 129 5 discriminator 1
	movs	r3, #30
	adds	r3, r7, r3
	ldrh	r2, [r3]
	movs	r3, #200
	lsls	r3, r3, #1
	cmp	r2, r3
	bcc	.L19
	.loc 1 136 1
	nop
	nop
	mov	sp, r7
	add	sp, sp, #32
	@ sp needed
	pop	{r7}
	pop	{r0}
	bx	r0
.L21:
	.align	2
.L20:
	.word	block_arr
	.cfi_endproc
.LFE2:
	.size	free, .-free
.Letext0:
	.file 2 "core.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x26f
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF23
	.byte	0xc
	.4byte	.LASF24
	.4byte	.LASF25
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF0
	.uleb128 0x3
	.4byte	.LASF2
	.byte	0x2
	.byte	0x2
	.byte	0x1c
	.4byte	0x38
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF1
	.uleb128 0x3
	.4byte	.LASF3
	.byte	0x2
	.byte	0x3
	.byte	0x1c
	.4byte	0x4b
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x5
	.4byte	.LASF6
	.byte	0x8
	.byte	0x1
	.byte	0xb
	.byte	0x10
	.4byte	0x81
	.uleb128 0x6
	.ascii	"loc\000"
	.byte	0x1
	.byte	0xc
	.byte	0xc
	.4byte	0x81
	.byte	0
	.uleb128 0x7
	.4byte	.LASF5
	.byte	0x1
	.byte	0xd
	.byte	0x9
	.4byte	0x52
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.byte	0x4
	.uleb128 0x3
	.4byte	.LASF6
	.byte	0x1
	.byte	0xe
	.byte	0x3
	.4byte	0x59
	.uleb128 0x9
	.4byte	.LASF7
	.2byte	0xc80
	.byte	0x1
	.byte	0x12
	.byte	0x10
	.4byte	0xab
	.uleb128 0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0x13
	.byte	0xf
	.4byte	0xab
	.byte	0
	.byte	0
	.uleb128 0xa
	.4byte	0x83
	.4byte	0xbc
	.uleb128 0xb
	.4byte	0x4b
	.2byte	0x18f
	.byte	0
	.uleb128 0x3
	.4byte	.LASF9
	.byte	0x1
	.byte	0x14
	.byte	0x3
	.4byte	0x8f
	.uleb128 0xc
	.4byte	.LASF10
	.byte	0x1
	.byte	0x17
	.byte	0x5
	.4byte	0x52
	.uleb128 0x5
	.byte	0x3
	.4byte	size_allocated
	.uleb128 0xc
	.4byte	.LASF11
	.byte	0x1
	.byte	0x18
	.byte	0x5
	.4byte	0x52
	.uleb128 0x5
	.byte	0x3
	.4byte	mem_block_size
	.uleb128 0xc
	.4byte	.LASF12
	.byte	0x1
	.byte	0x19
	.byte	0x5
	.4byte	0x52
	.uleb128 0x5
	.byte	0x3
	.4byte	num_alloced_blocks
	.uleb128 0xc
	.4byte	.LASF8
	.byte	0x1
	.byte	0x1a
	.byte	0x10
	.4byte	0x110
	.uleb128 0x5
	.byte	0x3
	.4byte	block_arr
	.uleb128 0xd
	.byte	0x4
	.4byte	0xbc
	.uleb128 0xe
	.4byte	.LASF26
	.byte	0x1
	.byte	0x75
	.byte	0x6
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x191
	.uleb128 0xf
	.ascii	"ptr\000"
	.byte	0x1
	.byte	0x75
	.byte	0x12
	.4byte	0x81
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x10
	.4byte	.LASF13
	.byte	0x1
	.byte	0x77
	.byte	0xc
	.4byte	0x81
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0x10
	.4byte	.LASF14
	.byte	0x1
	.byte	0x7a
	.byte	0xc
	.4byte	0x3f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x10
	.4byte	.LASF15
	.byte	0x1
	.byte	0x7d
	.byte	0xc
	.4byte	0x81
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x10
	.4byte	.LASF16
	.byte	0x1
	.byte	0x80
	.byte	0xc
	.4byte	0x2c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -10
	.uleb128 0x11
	.4byte	.LBB6
	.4byte	.LBE6-.LBB6
	.uleb128 0x10
	.4byte	.LASF17
	.byte	0x1
	.byte	0x82
	.byte	0x15
	.4byte	0x191
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.byte	0
	.uleb128 0xd
	.byte	0x4
	.4byte	0x83
	.uleb128 0x12
	.4byte	.LASF27
	.byte	0x1
	.byte	0x30
	.byte	0x8
	.4byte	0x81
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x248
	.uleb128 0x13
	.4byte	.LASF18
	.byte	0x1
	.byte	0x30
	.byte	0x16
	.4byte	0x3f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x10
	.4byte	.LASF19
	.byte	0x1
	.byte	0x31
	.byte	0x11
	.4byte	0x191
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x10
	.4byte	.LASF20
	.byte	0x1
	.byte	0x34
	.byte	0xc
	.4byte	0x3f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x10
	.4byte	.LASF5
	.byte	0x1
	.byte	0x40
	.byte	0xc
	.4byte	0x3f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x11
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.uleb128 0x14
	.ascii	"i\000"
	.byte	0x1
	.byte	0x42
	.byte	0xd
	.4byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x15
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.4byte	0x220
	.uleb128 0x10
	.4byte	.LASF21
	.byte	0x1
	.byte	0x4e
	.byte	0x14
	.4byte	0x81
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x11
	.4byte	.LBB5
	.4byte	.LBE5-.LBB5
	.uleb128 0x10
	.4byte	.LASF22
	.byte	0x1
	.byte	0x5b
	.byte	0x14
	.4byte	0x81
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x14
	.ascii	"j\000"
	.byte	0x1
	.byte	0x5e
	.byte	0x11
	.4byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.4byte	.LASF28
	.byte	0x1
	.byte	0x1d
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x11
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.uleb128 0x14
	.ascii	"i\000"
	.byte	0x1
	.byte	0x1f
	.byte	0xd
	.4byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -12
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0x5
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF3:
	.ascii	"uint32\000"
.LASF4:
	.ascii	"unsigned int\000"
.LASF15:
	.ascii	"block_end\000"
.LASF11:
	.ascii	"mem_block_size\000"
.LASF12:
	.ascii	"num_alloced_blocks\000"
.LASF9:
	.ascii	"block_arr_td\000"
.LASF23:
	.ascii	"GNU C17 9.1.0 -mthumb-interwork -mthumb -mcpu=arm7t"
	.ascii	"dmi -march=armv4t -g -fno-strict-aliasing\000"
.LASF22:
	.ascii	"allocated_addr\000"
.LASF14:
	.ascii	"alloced_size\000"
.LASF13:
	.ascii	"alloc_begin\000"
.LASF24:
	.ascii	"mem.c\000"
.LASF28:
	.ascii	"mem_init\000"
.LASF7:
	.ascii	"block_arr_t\000"
.LASF10:
	.ascii	"size_allocated\000"
.LASF17:
	.ascii	"curr_m_b\000"
.LASF0:
	.ascii	"unsigned char\000"
.LASF19:
	.ascii	"curr\000"
.LASF18:
	.ascii	"size_to_alloc\000"
.LASF21:
	.ascii	"alloced_addr\000"
.LASF8:
	.ascii	"block_arr\000"
.LASF1:
	.ascii	"short unsigned int\000"
.LASF5:
	.ascii	"size\000"
.LASF25:
	.ascii	"C:\\Users\\prasa\\Desktop\\CS\\GBAThread\000"
.LASF16:
	.ascii	"block_idx\000"
.LASF6:
	.ascii	"mem_block\000"
.LASF26:
	.ascii	"free\000"
.LASF2:
	.ascii	"uint16\000"
.LASF20:
	.ascii	"remainder_to_word\000"
.LASF27:
	.ascii	"malloc\000"
	.ident	"GCC: (devkitARM release 53) 9.1.0"
