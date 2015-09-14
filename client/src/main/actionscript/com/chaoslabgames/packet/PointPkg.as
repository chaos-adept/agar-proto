package com.chaoslabgames.packet {
	import com.netease.protobuf.*;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	use namespace used_by_generated_code;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PointPkg extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const X:FieldDescriptor_TYPE_FLOAT = new FieldDescriptor_TYPE_FLOAT("com.chaoslabgames.packet.PointPkg.x", "x", (1 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var x:Number;

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor_TYPE_FLOAT = new FieldDescriptor_TYPE_FLOAT("com.chaoslabgames.packet.PointPkg.y", "y", (2 << 3) | com.netease.protobuf.WireType.FIXED_32_BIT);

		public var y:Number;

		/**
		 *  @private
		 */
		override used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 1);
			com.netease.protobuf.WriteUtils.write_TYPE_FLOAT(output, this.x);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.FIXED_32_BIT, 2);
			com.netease.protobuf.WriteUtils.write_TYPE_FLOAT(output, this.y);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var x$count:uint = 0;
			var y$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read_TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: PointPkg.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 2:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: PointPkg.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read_TYPE_FLOAT(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
