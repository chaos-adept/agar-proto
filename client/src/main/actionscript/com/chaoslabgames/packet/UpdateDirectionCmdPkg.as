package com.chaoslabgames.packet {
	import com.netease.protobuf.*;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.chaoslabgames.packet.PointPkg;
	use namespace used_by_generated_code;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class UpdateDirectionCmdPkg extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const DIRECTION:FieldDescriptor_TYPE_MESSAGE = new FieldDescriptor_TYPE_MESSAGE("com.chaoslabgames.packet.UpdateDirectionCmdPkg.direction", "direction", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.chaoslabgames.packet.PointPkg; });

		public var direction:com.chaoslabgames.packet.PointPkg;

		/**
		 *  @private
		 */
		override used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write_TYPE_MESSAGE(output, this.direction);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var direction$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read_TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (direction$count != 0) {
						throw new flash.errors.IOError('Bad data format: UpdateDirectionCmdPkg.direction cannot be set twice.');
					}
					++direction$count;
					this.direction = new com.chaoslabgames.packet.PointPkg();
					com.netease.protobuf.ReadUtils.read_TYPE_MESSAGE(input, this.direction);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
