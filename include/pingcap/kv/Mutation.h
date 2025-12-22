#pragma once

#include <kvproto/kvrpcpb.pb.h>

#include <string>

namespace pingcap
{
namespace kv
{

struct Mutation
{
    kvrpcpb::Op op;
    std::string value;
};

} // namespace kv
} // namespace pingcap
