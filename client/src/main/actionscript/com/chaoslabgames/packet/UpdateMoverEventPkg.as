package com.chaoslabgames.packet {
	import com.netease.protobuf.*;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.chaoslabgames.packet.MoverDataPkg;
	use namespace used_by_generated_code;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class UpdateMoverEventPkg extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor_TYPE_INT64 = new FieldDescriptor_TYPE_INT64("com.chaoslabgames.packet.UpdateMoverEventPkg.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var id:Int64;

		/**
		 *  @private
		 */
		public static const MOVERDATA:FieldDescriptor_TYPE_MESSAGE = new FieldDescriptor_TYPE_MESSAGE("com.chaoslabgames.packet.UpdateMoverEventPkg.moverData", "moverData", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.chaoslabgames.packet.MoverDataPkg; });

		public var moverData:com.chaoslabgames.packet.MoverDataPkg;

		/**
		 *  @private
		 */
		override used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write_TYPE_INT64(output, this.id);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
			com.netease.protobuf.WriteUtils.write_TYPE_MESSAGE(output, this.moverData);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var id$count:uint = 0;
			var moverData$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read_TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: UpdateMoverEventPkg.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read_TYPE_INT64(input);
					break;
				case 2:
					if (moverData$count != 0) {
						throw new flash.errors.IOError('Bad data format: UpdateMoverEventPkg.moverData cannot be set twice.');
					}
					++moverData$count;
					this.moverData = new com.chaoslabgames.packet.MoverDataPkg();
					com.netease.protobuf.ReadUtils.read_TYPE_MESSAGE(input, this.moverData);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
