// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: packages.proto

package com.chaoslabgames.packet;

/**
 * Protobuf type {@code com.chaoslabgames.packet.UpdateMoverEventPkg}
 */
public final class UpdateMoverEventPkg extends
    com.google.protobuf.GeneratedMessage implements
    // @@protoc_insertion_point(message_implements:com.chaoslabgames.packet.UpdateMoverEventPkg)
    UpdateMoverEventPkgOrBuilder {
  // Use UpdateMoverEventPkg.newBuilder() to construct.
  private UpdateMoverEventPkg(com.google.protobuf.GeneratedMessage.Builder<?> builder) {
    super(builder);
    this.unknownFields = builder.getUnknownFields();
  }
  private UpdateMoverEventPkg(boolean noInit) { this.unknownFields = com.google.protobuf.UnknownFieldSet.getDefaultInstance(); }

  private static final UpdateMoverEventPkg defaultInstance;
  public static UpdateMoverEventPkg getDefaultInstance() {
    return defaultInstance;
  }

  public UpdateMoverEventPkg getDefaultInstanceForType() {
    return defaultInstance;
  }

  private final com.google.protobuf.UnknownFieldSet unknownFields;
  @java.lang.Override
  public final com.google.protobuf.UnknownFieldSet
      getUnknownFields() {
    return this.unknownFields;
  }
  private UpdateMoverEventPkg(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    initFields();
    int mutable_bitField0_ = 0;
    com.google.protobuf.UnknownFieldSet.Builder unknownFields =
        com.google.protobuf.UnknownFieldSet.newBuilder();
    try {
      boolean done = false;
      while (!done) {
        int tag = input.readTag();
        switch (tag) {
          case 0:
            done = true;
            break;
          default: {
            if (!parseUnknownField(input, unknownFields,
                                   extensionRegistry, tag)) {
              done = true;
            }
            break;
          }
          case 8: {
            bitField0_ |= 0x00000001;
            id_ = input.readInt64();
            break;
          }
          case 18: {
            com.chaoslabgames.packet.MoverDataPkg.Builder subBuilder = null;
            if (((bitField0_ & 0x00000002) == 0x00000002)) {
              subBuilder = moverData_.toBuilder();
            }
            moverData_ = input.readMessage(com.chaoslabgames.packet.MoverDataPkg.PARSER, extensionRegistry);
            if (subBuilder != null) {
              subBuilder.mergeFrom(moverData_);
              moverData_ = subBuilder.buildPartial();
            }
            bitField0_ |= 0x00000002;
            break;
          }
        }
      }
    } catch (com.google.protobuf.InvalidProtocolBufferException e) {
      throw e.setUnfinishedMessage(this);
    } catch (java.io.IOException e) {
      throw new com.google.protobuf.InvalidProtocolBufferException(
          e.getMessage()).setUnfinishedMessage(this);
    } finally {
      this.unknownFields = unknownFields.build();
      makeExtensionsImmutable();
    }
  }
  public static final com.google.protobuf.Descriptors.Descriptor
      getDescriptor() {
    return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_UpdateMoverEventPkg_descriptor;
  }

  protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internalGetFieldAccessorTable() {
    return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_UpdateMoverEventPkg_fieldAccessorTable
        .ensureFieldAccessorsInitialized(
            com.chaoslabgames.packet.UpdateMoverEventPkg.class, com.chaoslabgames.packet.UpdateMoverEventPkg.Builder.class);
  }

  public static com.google.protobuf.Parser<UpdateMoverEventPkg> PARSER =
      new com.google.protobuf.AbstractParser<UpdateMoverEventPkg>() {
    public UpdateMoverEventPkg parsePartialFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return new UpdateMoverEventPkg(input, extensionRegistry);
    }
  };

  @java.lang.Override
  public com.google.protobuf.Parser<UpdateMoverEventPkg> getParserForType() {
    return PARSER;
  }

  private int bitField0_;
  public static final int ID_FIELD_NUMBER = 1;
  private long id_;
  /**
   * <code>required int64 id = 1;</code>
   */
  public boolean hasId() {
    return ((bitField0_ & 0x00000001) == 0x00000001);
  }
  /**
   * <code>required int64 id = 1;</code>
   */
  public long getId() {
    return id_;
  }

  public static final int MOVERDATA_FIELD_NUMBER = 2;
  private com.chaoslabgames.packet.MoverDataPkg moverData_;
  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
   */
  public boolean hasMoverData() {
    return ((bitField0_ & 0x00000002) == 0x00000002);
  }
  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
   */
  public com.chaoslabgames.packet.MoverDataPkg getMoverData() {
    return moverData_;
  }
  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
   */
  public com.chaoslabgames.packet.MoverDataPkgOrBuilder getMoverDataOrBuilder() {
    return moverData_;
  }

  private void initFields() {
    id_ = 0L;
    moverData_ = com.chaoslabgames.packet.MoverDataPkg.getDefaultInstance();
  }
  private byte memoizedIsInitialized = -1;
  public final boolean isInitialized() {
    byte isInitialized = memoizedIsInitialized;
    if (isInitialized == 1) return true;
    if (isInitialized == 0) return false;

    if (!hasId()) {
      memoizedIsInitialized = 0;
      return false;
    }
    if (!hasMoverData()) {
      memoizedIsInitialized = 0;
      return false;
    }
    if (!getMoverData().isInitialized()) {
      memoizedIsInitialized = 0;
      return false;
    }
    memoizedIsInitialized = 1;
    return true;
  }

  public void writeTo(com.google.protobuf.CodedOutputStream output)
                      throws java.io.IOException {
    getSerializedSize();
    if (((bitField0_ & 0x00000001) == 0x00000001)) {
      output.writeInt64(1, id_);
    }
    if (((bitField0_ & 0x00000002) == 0x00000002)) {
      output.writeMessage(2, moverData_);
    }
    getUnknownFields().writeTo(output);
  }

  private int memoizedSerializedSize = -1;
  public int getSerializedSize() {
    int size = memoizedSerializedSize;
    if (size != -1) return size;

    size = 0;
    if (((bitField0_ & 0x00000001) == 0x00000001)) {
      size += com.google.protobuf.CodedOutputStream
        .computeInt64Size(1, id_);
    }
    if (((bitField0_ & 0x00000002) == 0x00000002)) {
      size += com.google.protobuf.CodedOutputStream
        .computeMessageSize(2, moverData_);
    }
    size += getUnknownFields().getSerializedSize();
    memoizedSerializedSize = size;
    return size;
  }

  private static final long serialVersionUID = 0L;
  @java.lang.Override
  protected java.lang.Object writeReplace()
      throws java.io.ObjectStreamException {
    return super.writeReplace();
  }

  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      com.google.protobuf.ByteString data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      com.google.protobuf.ByteString data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(byte[] data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      byte[] data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseDelimitedFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseDelimitedFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input, extensionRegistry);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      com.google.protobuf.CodedInputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.chaoslabgames.packet.UpdateMoverEventPkg parseFrom(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }

  public static Builder newBuilder() { return Builder.create(); }
  public Builder newBuilderForType() { return newBuilder(); }
  public static Builder newBuilder(com.chaoslabgames.packet.UpdateMoverEventPkg prototype) {
    return newBuilder().mergeFrom(prototype);
  }
  public Builder toBuilder() { return newBuilder(this); }

  @java.lang.Override
  protected Builder newBuilderForType(
      com.google.protobuf.GeneratedMessage.BuilderParent parent) {
    Builder builder = new Builder(parent);
    return builder;
  }
  /**
   * Protobuf type {@code com.chaoslabgames.packet.UpdateMoverEventPkg}
   */
  public static final class Builder extends
      com.google.protobuf.GeneratedMessage.Builder<Builder> implements
      // @@protoc_insertion_point(builder_implements:com.chaoslabgames.packet.UpdateMoverEventPkg)
      com.chaoslabgames.packet.UpdateMoverEventPkgOrBuilder {
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_UpdateMoverEventPkg_descriptor;
    }

    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_UpdateMoverEventPkg_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              com.chaoslabgames.packet.UpdateMoverEventPkg.class, com.chaoslabgames.packet.UpdateMoverEventPkg.Builder.class);
    }

    // Construct using com.chaoslabgames.packet.UpdateMoverEventPkg.newBuilder()
    private Builder() {
      maybeForceBuilderInitialization();
    }

    private Builder(
        com.google.protobuf.GeneratedMessage.BuilderParent parent) {
      super(parent);
      maybeForceBuilderInitialization();
    }
    private void maybeForceBuilderInitialization() {
      if (com.google.protobuf.GeneratedMessage.alwaysUseFieldBuilders) {
        getMoverDataFieldBuilder();
      }
    }
    private static Builder create() {
      return new Builder();
    }

    public Builder clear() {
      super.clear();
      id_ = 0L;
      bitField0_ = (bitField0_ & ~0x00000001);
      if (moverDataBuilder_ == null) {
        moverData_ = com.chaoslabgames.packet.MoverDataPkg.getDefaultInstance();
      } else {
        moverDataBuilder_.clear();
      }
      bitField0_ = (bitField0_ & ~0x00000002);
      return this;
    }

    public Builder clone() {
      return create().mergeFrom(buildPartial());
    }

    public com.google.protobuf.Descriptors.Descriptor
        getDescriptorForType() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_UpdateMoverEventPkg_descriptor;
    }

    public com.chaoslabgames.packet.UpdateMoverEventPkg getDefaultInstanceForType() {
      return com.chaoslabgames.packet.UpdateMoverEventPkg.getDefaultInstance();
    }

    public com.chaoslabgames.packet.UpdateMoverEventPkg build() {
      com.chaoslabgames.packet.UpdateMoverEventPkg result = buildPartial();
      if (!result.isInitialized()) {
        throw newUninitializedMessageException(result);
      }
      return result;
    }

    public com.chaoslabgames.packet.UpdateMoverEventPkg buildPartial() {
      com.chaoslabgames.packet.UpdateMoverEventPkg result = new com.chaoslabgames.packet.UpdateMoverEventPkg(this);
      int from_bitField0_ = bitField0_;
      int to_bitField0_ = 0;
      if (((from_bitField0_ & 0x00000001) == 0x00000001)) {
        to_bitField0_ |= 0x00000001;
      }
      result.id_ = id_;
      if (((from_bitField0_ & 0x00000002) == 0x00000002)) {
        to_bitField0_ |= 0x00000002;
      }
      if (moverDataBuilder_ == null) {
        result.moverData_ = moverData_;
      } else {
        result.moverData_ = moverDataBuilder_.build();
      }
      result.bitField0_ = to_bitField0_;
      onBuilt();
      return result;
    }

    public Builder mergeFrom(com.google.protobuf.Message other) {
      if (other instanceof com.chaoslabgames.packet.UpdateMoverEventPkg) {
        return mergeFrom((com.chaoslabgames.packet.UpdateMoverEventPkg)other);
      } else {
        super.mergeFrom(other);
        return this;
      }
    }

    public Builder mergeFrom(com.chaoslabgames.packet.UpdateMoverEventPkg other) {
      if (other == com.chaoslabgames.packet.UpdateMoverEventPkg.getDefaultInstance()) return this;
      if (other.hasId()) {
        setId(other.getId());
      }
      if (other.hasMoverData()) {
        mergeMoverData(other.getMoverData());
      }
      this.mergeUnknownFields(other.getUnknownFields());
      return this;
    }

    public final boolean isInitialized() {
      if (!hasId()) {
        
        return false;
      }
      if (!hasMoverData()) {
        
        return false;
      }
      if (!getMoverData().isInitialized()) {
        
        return false;
      }
      return true;
    }

    public Builder mergeFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      com.chaoslabgames.packet.UpdateMoverEventPkg parsedMessage = null;
      try {
        parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        parsedMessage = (com.chaoslabgames.packet.UpdateMoverEventPkg) e.getUnfinishedMessage();
        throw e;
      } finally {
        if (parsedMessage != null) {
          mergeFrom(parsedMessage);
        }
      }
      return this;
    }
    private int bitField0_;

    private long id_ ;
    /**
     * <code>required int64 id = 1;</code>
     */
    public boolean hasId() {
      return ((bitField0_ & 0x00000001) == 0x00000001);
    }
    /**
     * <code>required int64 id = 1;</code>
     */
    public long getId() {
      return id_;
    }
    /**
     * <code>required int64 id = 1;</code>
     */
    public Builder setId(long value) {
      bitField0_ |= 0x00000001;
      id_ = value;
      onChanged();
      return this;
    }
    /**
     * <code>required int64 id = 1;</code>
     */
    public Builder clearId() {
      bitField0_ = (bitField0_ & ~0x00000001);
      id_ = 0L;
      onChanged();
      return this;
    }

    private com.chaoslabgames.packet.MoverDataPkg moverData_ = com.chaoslabgames.packet.MoverDataPkg.getDefaultInstance();
    private com.google.protobuf.SingleFieldBuilder<
        com.chaoslabgames.packet.MoverDataPkg, com.chaoslabgames.packet.MoverDataPkg.Builder, com.chaoslabgames.packet.MoverDataPkgOrBuilder> moverDataBuilder_;
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public boolean hasMoverData() {
      return ((bitField0_ & 0x00000002) == 0x00000002);
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public com.chaoslabgames.packet.MoverDataPkg getMoverData() {
      if (moverDataBuilder_ == null) {
        return moverData_;
      } else {
        return moverDataBuilder_.getMessage();
      }
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public Builder setMoverData(com.chaoslabgames.packet.MoverDataPkg value) {
      if (moverDataBuilder_ == null) {
        if (value == null) {
          throw new NullPointerException();
        }
        moverData_ = value;
        onChanged();
      } else {
        moverDataBuilder_.setMessage(value);
      }
      bitField0_ |= 0x00000002;
      return this;
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public Builder setMoverData(
        com.chaoslabgames.packet.MoverDataPkg.Builder builderForValue) {
      if (moverDataBuilder_ == null) {
        moverData_ = builderForValue.build();
        onChanged();
      } else {
        moverDataBuilder_.setMessage(builderForValue.build());
      }
      bitField0_ |= 0x00000002;
      return this;
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public Builder mergeMoverData(com.chaoslabgames.packet.MoverDataPkg value) {
      if (moverDataBuilder_ == null) {
        if (((bitField0_ & 0x00000002) == 0x00000002) &&
            moverData_ != com.chaoslabgames.packet.MoverDataPkg.getDefaultInstance()) {
          moverData_ =
            com.chaoslabgames.packet.MoverDataPkg.newBuilder(moverData_).mergeFrom(value).buildPartial();
        } else {
          moverData_ = value;
        }
        onChanged();
      } else {
        moverDataBuilder_.mergeFrom(value);
      }
      bitField0_ |= 0x00000002;
      return this;
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public Builder clearMoverData() {
      if (moverDataBuilder_ == null) {
        moverData_ = com.chaoslabgames.packet.MoverDataPkg.getDefaultInstance();
        onChanged();
      } else {
        moverDataBuilder_.clear();
      }
      bitField0_ = (bitField0_ & ~0x00000002);
      return this;
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public com.chaoslabgames.packet.MoverDataPkg.Builder getMoverDataBuilder() {
      bitField0_ |= 0x00000002;
      onChanged();
      return getMoverDataFieldBuilder().getBuilder();
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    public com.chaoslabgames.packet.MoverDataPkgOrBuilder getMoverDataOrBuilder() {
      if (moverDataBuilder_ != null) {
        return moverDataBuilder_.getMessageOrBuilder();
      } else {
        return moverData_;
      }
    }
    /**
     * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 2;</code>
     */
    private com.google.protobuf.SingleFieldBuilder<
        com.chaoslabgames.packet.MoverDataPkg, com.chaoslabgames.packet.MoverDataPkg.Builder, com.chaoslabgames.packet.MoverDataPkgOrBuilder> 
        getMoverDataFieldBuilder() {
      if (moverDataBuilder_ == null) {
        moverDataBuilder_ = new com.google.protobuf.SingleFieldBuilder<
            com.chaoslabgames.packet.MoverDataPkg, com.chaoslabgames.packet.MoverDataPkg.Builder, com.chaoslabgames.packet.MoverDataPkgOrBuilder>(
                getMoverData(),
                getParentForChildren(),
                isClean());
        moverData_ = null;
      }
      return moverDataBuilder_;
    }

    // @@protoc_insertion_point(builder_scope:com.chaoslabgames.packet.UpdateMoverEventPkg)
  }

  static {
    defaultInstance = new UpdateMoverEventPkg(true);
    defaultInstance.initFields();
  }

  // @@protoc_insertion_point(class_scope:com.chaoslabgames.packet.UpdateMoverEventPkg)
}

