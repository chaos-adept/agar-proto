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
	public final class MoverDataPkg extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const POSITION:FieldDescriptor_TYPE_MESSAGE = new FieldDescriptor_TYPE_MESSAGE("com.chaoslabgames.packet.MoverDataPkg.position", "position", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.chaoslabgames.packet.PointPkg; });

		public var position:com.chaoslabgames.packet.PointPkg;

		/**
		 *  @private
		 */
		public static const DIRECTION:FieldDescriptor_TYPE_MESSAGE = new FieldDescriptor_TYPE_MESSAGE("com.chaoslabgames.packet.MoverDataPkg.direction", "direction", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.chaoslabgames.packet.PointPkg; });

		public var direction:com.chaoslabgames.packet.PointPkg;

		/**
		 *  @private
		 */
		public static const COLOR:FieldDescriptor_TYPE_INT32 = new FieldDescriptor_TYPE_INT32("com.chaoslabgames.packet.MoverDataPkg.color", "color", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		public var color:int;

		/**
		 *  @private
		 */
		override used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
			com.netease.protobuf.WriteUtils.write_TYPE_MESSAGE(output, this.position);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write_TYPE_MESSAGE(output, this.direction);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
			com.netease.protobuf.WriteUtils.write_TYPE_INT32(output, this.color);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var position$count:uint = 0;
			var direction$count:uint = 0;
			var color$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read_TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (position$count != 0) {
						throw new flash.errors.IOError('Bad data format: MoverDataPkg.position cannot be set twice.');
					}
					++position$count;
					this.position = new com.chaoslabgames.packet.PointPkg();
					com.netease.protobuf.ReadUtils.read_TYPE_MESSAGE(input, this.position);
					break;
				case 2:
					if (direction$count != 0) {
						throw new flash.errors.IOError('Bad data format: MoverDataPkg.direction cannot be set twice.');
					}
					++direction$count;
					this.direction = new com.chaoslabgames.packet.PointPkg();
					com.netease.protobuf.ReadUtils.read_TYPE_MESSAGE(input, this.direction);
					break;
				case 3:
					if (color$count != 0) {
						throw new flash.errors.IOError('Bad data format: MoverDataPkg.color cannot be set twice.');
					}
					++color$count;
					this.color = com.netease.protobuf.ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
