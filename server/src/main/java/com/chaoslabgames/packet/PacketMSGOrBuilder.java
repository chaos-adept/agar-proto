// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: packages.proto

package com.chaoslabgames.packet;

public interface PacketMSGOrBuilder extends
    // @@protoc_insertion_point(interface_extends:com.chaoslabgames.packet.PacketMSG)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>optional bool ping = 1;</code>
   *
   * <pre>
   * base
   * </pre>
   */
  boolean hasPing();
  /**
   * <code>optional bool ping = 1;</code>
   *
   * <pre>
   * base
   * </pre>
   */
  boolean getPing();

  /**
   * <code>optional int32 type = 2;</code>
   *
   * <pre>
   * data
   * </pre>
   */
  boolean hasType();
  /**
   * <code>optional int32 type = 2;</code>
   *
   * <pre>
   * data
   * </pre>
   */
  int getType();

  /**
   * <code>optional bytes data = 3;</code>
   */
  boolean hasData();
  /**
   * <code>optional bytes data = 3;</code>
   */
  com.google.protobuf.ByteString getData();
}
